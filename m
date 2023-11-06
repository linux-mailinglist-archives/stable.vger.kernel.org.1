Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AD07E2553
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjKFNa4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjKFNay (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:30:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB98D8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:30:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3712C433C7;
        Mon,  6 Nov 2023 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277451;
        bh=Kr1mzh1uYI4WNJIcFl8g3q8vXQ7Zu6B82UH/TfWC3o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pi/vI9QTiAgHyVZPmWv7kKEfK5IqOFgHlJEOW1lH/9e/RTYX3DNNl9F2QNwG4L9lC
         sG9xGmf9z2ZUznmvPROcItc3H62TrU/xrpkDUwloVLBSPFxbjb+FZMmzIk7GwQLmBn
         BE9LgzsfQq5xQHSPxY5tWUSOQMAGoZwArgCM4gLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 06/95] mm/page_alloc: correct start page when guard page debug is enabled
Date:   Mon,  6 Nov 2023 14:03:34 +0100
Message-ID: <20231106130304.911347263@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit 61e21cf2d2c3cc5e60e8d0a62a77e250fccda62c upstream.

When guard page debug is enabled and set_page_guard returns success, we
miss to forward page to point to start of next split range and we will do
split unexpectedly in page range without target page.  Move start page
update before set_page_guard to fix this.

As we split to wrong target page, then splited pages are not able to merge
back to original order when target page is put back and splited pages
except target page is not usable.  To be specific:

Consider target page is the third page in buddy page with order 2.
| buddy-2 | Page | Target | Page |

After break down to target page, we will only set first page to Guard
because of bug.
| Guard   | Page | Target | Page |

When we try put_page_back_buddy with target page, the buddy page of target
if neither guard nor buddy, Then it's not able to construct original page
with order 2
| Guard | Page | buddy-0 | Page |

All pages except target page is not in free list and is not usable.

Link: https://lkml.kernel.org/r/20230927094401.68205-1-shikemeng@huaweicloud.com
Fixes: 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8932,6 +8932,7 @@ static void break_down_buddy_pages(struc
 			next_page = page;
 			current_buddy = page + size;
 		}
+		page = next_page;
 
 		if (set_page_guard(zone, current_buddy, high, migratetype))
 			continue;
@@ -8939,7 +8940,6 @@ static void break_down_buddy_pages(struc
 		if (current_buddy != target) {
 			add_to_free_list(current_buddy, zone, high, migratetype);
 			set_buddy_order(current_buddy, high);
-			page = next_page;
 		}
 	}
 }


