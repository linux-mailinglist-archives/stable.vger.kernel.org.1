Return-Path: <stable+bounces-2457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0987F8441
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB101C25272
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454333CC2;
	Fri, 24 Nov 2023 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GnM8Iodw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476E1A5A4;
	Fri, 24 Nov 2023 19:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FFDC433C8;
	Fri, 24 Nov 2023 19:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853930;
	bh=8CKsprRGrtkiJtr/QUCduO38Z+qQyZCAecjmIdMeuEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GnM8IodwHUuhijARhPdGUCvdU7wZyUj8yfvs8XY39486DiFY+nBvVEClwDUhvBKwh
	 CI10wH4JzA+0aG5K7FN7DkpUrDjpSJ+yuO5th7GYMos/OsW6Jx4lu7o28sKprNPE9l
	 uWSEDMPKv54rYEg5xOQqEhPC7dbyvMY3CHgRApCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Geffon <bgeffon@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 087/159] PM: hibernate: Use __get_safe_page() rather than touching the list
Date: Fri, 24 Nov 2023 17:55:04 +0000
Message-ID: <20231124171945.542726975@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Geffon <bgeffon@google.com>

commit f0c7183008b41e92fa676406d87f18773724b48b upstream.

We found at least one situation where the safe pages list was empty and
get_buffer() would gladly try to use a NULL pointer.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Fixes: 8357376d3df2 ("[PATCH] swsusp: Improve handling of highmem")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/power/snapshot.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2377,8 +2377,9 @@ static void *get_highmem_page_buffer(str
 		pbe->copy_page = tmp;
 	} else {
 		/* Copy of the page will be stored in normal memory */
-		kaddr = safe_pages_list;
-		safe_pages_list = safe_pages_list->next;
+		kaddr = __get_safe_page(ca->gfp_mask);
+		if (!kaddr)
+			return ERR_PTR(-ENOMEM);
 		pbe->copy_page = virt_to_page(kaddr);
 	}
 	pbe->next = highmem_pblist;
@@ -2558,8 +2559,9 @@ static void *get_buffer(struct memory_bi
 		return ERR_PTR(-ENOMEM);
 	}
 	pbe->orig_address = page_address(page);
-	pbe->address = safe_pages_list;
-	safe_pages_list = safe_pages_list->next;
+	pbe->address = __get_safe_page(ca->gfp_mask);
+	if (!pbe->address)
+		return ERR_PTR(-ENOMEM);
 	pbe->next = restore_pblist;
 	restore_pblist = pbe;
 	return pbe->address;



