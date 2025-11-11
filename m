Return-Path: <stable+bounces-193181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4BFC4A04F
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52B6188CD06
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12C246333;
	Tue, 11 Nov 2025 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FiVOT/aI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2984C97;
	Tue, 11 Nov 2025 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822488; cv=none; b=SOkVGvWl8KuZJKk7Dy4/obWBvP2PbZ/qHlEwIRWZdoNhvGhARB4lIubwigvxXPgOz8aQ0cygXoAEtnhQDskQSbepD8uyuqzPSQ+O45BqN5Ojp5Kbf4Mb3HOuRJMH7uKMGe/D/WB5JflhC36bJKMPxijLPLJfKGT1JMu8+5In3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822488; c=relaxed/simple;
	bh=YDQaxWjOtOBUOi4Wg+hcSvjepwHN1oRun6ZT6usYKtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kc+4h/70QrZ7jyU/oe1z4KeR0L/ckBkOUvA6UYHvYMMg7X255YIVc2iPCZ5OWMEOUaMKbZB2dox7CXlMR1dHc7VvBi/fndqRLs3XsZJ2YNuRwUpxDGApmzFMwo7j7mbOL4SiaC/dBBNATKeGPRff3Pf0yT5ZDi1P9J1V/BSTxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FiVOT/aI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D213C113D0;
	Tue, 11 Nov 2025 00:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822488;
	bh=YDQaxWjOtOBUOi4Wg+hcSvjepwHN1oRun6ZT6usYKtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FiVOT/aIeZ/d6e3ZFM6MldDDoe/b8pB7lXiz3BoTRiaACCOFTPm8uC0Z3EKP50zBP
	 cc6gNGdZUDxBmh4HniBXRoRCPrhjGaL0gSPZBqqwjo7h9dfSDYP37wueuXUQEdSB9w
	 esmJ/qyg2A3gSeL8VmBT4wyuvtvH7aIlDceERFZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 060/565] block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
Date: Tue, 11 Nov 2025 09:38:36 +0900
Message-ID: <20251111004528.274726931@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 12a1c9353c47c0fb3464eba2d78cdf649dee1cf7 upstream.

REQ_OP_ZONE_RESET_ALL is a zone management request. Fix
op_is_zone_mgmt() to return true for that operation, like it already
does for REQ_OP_ZONE_RESET.

While no problems were reported without this fix, this change allows
strengthening checks in various block device drivers (scsi sd,
virtioblk, DM) where op_is_zone_mgmt() is used to verify that a zone
management command is not being issued to a regular block device.

Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/blk_types.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -473,6 +473,7 @@ static inline bool op_is_zone_mgmt(enum
 {
 	switch (op & REQ_OP_MASK) {
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_FINISH:



