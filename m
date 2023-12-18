Return-Path: <stable+bounces-7226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9784081717E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206FF283803
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B81D12B;
	Mon, 18 Dec 2023 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBjf7WVc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68093129ED2;
	Mon, 18 Dec 2023 13:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18ABC433C7;
	Mon, 18 Dec 2023 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907903;
	bh=gAzkmycIOzFBdTutH2EuA4ebp0oAfxGV/8oyX1uz3BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBjf7WVctiti+FvuxqcyDAuXBnedagN48+PT29HGhfAIQ80nkBIXzzaTjPdh2bbU6
	 xEtWbHY1ja9Af+Fk2T4SSTH2G2bG71idB4EK/2XRr/RlshNcEN2UllodyX4x8nYxZp
	 eY5dEvxqx20O5b0fViVh7kH//zdorhgAMz0UQAME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 088/106] btrfs: dont clear qgroup reserved bit in release_folio
Date: Mon, 18 Dec 2023 14:51:42 +0100
Message-ID: <20231218135058.837802827@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

commit a86805504b88f636a6458520d85afdf0634e3c6b upstream.

The EXTENT_QGROUP_RESERVED bit is used to "lock" regions of the file for
duplicate reservations. That is two writes to that range in one
transaction shouldn't create two reservations, as the reservation will
only be freed once when the write finally goes down. Therefore, it is
never OK to clear that bit without freeing the associated qgroup
reserve. At this point, we don't want to be freeing the reserve, so mask
off the bit.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3390,7 +3390,8 @@ static int try_release_extent_state(stru
 		ret = 0;
 	} else {
 		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
-				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
+				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS |
+				   EXTENT_QGROUP_RESERVED);
 
 		/*
 		 * At this point we can safely clear everything except the



