Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3F713FF1
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjE1Tup (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjE1Tuo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427259E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE42A62063
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFF4C433EF;
        Sun, 28 May 2023 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303442;
        bh=WXwKQFUFHTePe9KV8JYxxR3K/l6YyjgBANdDlwYLIKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcdvyIX2OjkcxF+nbNvWywOdANP1F2v7tkH3mWetxtuCgRFr6VCX+e9FUl0dYAMMm
         AGYlBVfnWASi9Oq70pCF9XGiKKqt9PHoETO9M+YoqzQx9I29NhZRdkGPg6bwfxsnco
         ZUnampqcTGV0VIrbwv59dbtY7XlFibB6OB47l1Ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 5.15 66/69] firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory descriptors
Date:   Sun, 28 May 2023 20:12:26 +0100
Message-Id: <20230528190830.850693161@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

commit 111a833dc5cbef3d05b2a796a7e23cb7f6ff2192 upstream.

The transmit buffers allocated by the driver can be used to transmit data
by any messages/commands needing the buffer. However, it is not guaranteed
to have been zero-ed before every new transmission and hence it will just
contain residual value from the previous transmission. There are several
reserved fields in the memory descriptors that must be zero(MBZ). The
receiver can reject the transmission if any such MBZ fields are non-zero.

While we can set the whole page to zero, it is not optimal as most of the
fields get initialised to the value required for the current transmission.

So, just set the reserved/MBZ fields to zero in the memory descriptors
explicitly to honour the requirement and keep the receiver happy.

Fixes: cc2195fe536c ("firmware: arm_ffa: Add support for MEM_* interfaces")
Reported-by: Marc Bonnici <marc.bonnici@arm.com>
Link: https://lore.kernel.org/r/20230503131252.12585-1-sudeep.holla@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/arm_ffa/driver.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -451,12 +451,17 @@ ffa_setup_and_transmit(u32 func_id, void
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
 		ep_mem_access->composite_off = COMPOSITE_OFFSET(args->nattrs);
+		ep_mem_access->flag = 0;
+		ep_mem_access->reserved = 0;
 	}
+	mem_region->reserved_0 = 0;
+	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
 
 	composite = buffer + COMPOSITE_OFFSET(args->nattrs);
 	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
 	composite->addr_range_cnt = num_entries;
+	composite->reserved = 0;
 
 	length = COMPOSITE_CONSTITUENTS_OFFSET(args->nattrs, num_entries);
 	frag_len = COMPOSITE_CONSTITUENTS_OFFSET(args->nattrs, 0);
@@ -491,6 +496,7 @@ ffa_setup_and_transmit(u32 func_id, void
 
 		constituents->address = sg_phys(args->sg);
 		constituents->pg_cnt = args->sg->length / FFA_PAGE_SIZE;
+		constituents->reserved = 0;
 		constituents++;
 		frag_len += sizeof(struct ffa_mem_region_addr_range);
 	} while ((args->sg = sg_next(args->sg)));


