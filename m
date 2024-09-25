Return-Path: <stable+bounces-77663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1B0985FA2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3685A1F25FDF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E91D4436;
	Wed, 25 Sep 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaXeVjRG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58F1D442C;
	Wed, 25 Sep 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266632; cv=none; b=U34/oV0zJ/fBXQMDH/1kyQSbTYFbMirMlY6BnWuPd/CALP9sgFgvIOhD1pBgobFvteEFK5JMY/3RBlUWn9B4Bu2BQO6sHT2ElSYTSeX4XGUctsMRx+ApSc5vvHu5vpjmJGWSh6R+2LYHdOf14/bNY5BYv8wMG8Bcs0pVccEwWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266632; c=relaxed/simple;
	bh=wdK8y6bGYpKJjysnbbSwWhxoTi3D5LCnlnLcIxyaXyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7XJ4v0srXHdVuuI79RZ6d8jO76vNpmI/1ivvy6dOYRhOlyPvyR+c7/mav8/yW1KoFhN+S2sG71Sia4dgLsMMG2PHccESN0ZVd4s8v4DQ1goRn6OLpsDd1jRo97+EZo/5vE7YPvh3xWoa3OGMhfBLS5V2+XbRQYtO8zyHjfuZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaXeVjRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C182AC4CEC3;
	Wed, 25 Sep 2024 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266631;
	bh=wdK8y6bGYpKJjysnbbSwWhxoTi3D5LCnlnLcIxyaXyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaXeVjRGXxJnc6pgq7v2gW8lFYTL2uJROLjO4xqMmNAdKWKPdY2tK2wdOk5H72c0R
	 sFZutF5GxR2JEomw1YwpCsB/b0zEhwDLpxSdmqXfRuflIXemH1tdS2R2tfio87t1+w
	 SkehJmTS76HqDL/Vbsp0U8eV/STl7psw93m0E3BTktBjfs/Mt/UCTjKI98pjNgz7CO
	 NBOnSkD97IIC3hEEF/7q/XmFHLuRXcNL/r1YqnPIAH5nLurZ6rsUhAKtDtd75oyFmo
	 nH0Q8jfarIcegunspjFanMYzPC4NPjv5nudyzOITFKK5drVShurSCt2tk8v4+frVzt
	 ZwArL6k23+GqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 116/139] scsi: aacraid: Rearrange order of struct aac_srb_unit
Date: Wed, 25 Sep 2024 08:08:56 -0400
Message-ID: <20240925121137.1307574-116-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 6e5860b0ad4934baee8c7a202c02033b2631bb44 ]

struct aac_srb_unit contains struct aac_srb, which contains struct sgmap,
which ends in a (currently) "fake" (1-element) flexible array.  Converting
this to a flexible array is needed so that runtime bounds checking won't
think the array is fixed size (i.e. under CONFIG_FORTIFY_SOURCE=y and/or
CONFIG_UBSAN_BOUNDS=y), as other parts of aacraid use struct sgmap as a
flexible array.

It is not legal to have a flexible array in the middle of a structure, so
it either needs to be split up or rearranged so that it is at the end of
the structure. Luckily, struct aac_srb_unit, which is exclusively
consumed/updated by aac_send_safw_bmic_cmd(), does not depend on member
ordering.

The values set in the on-stack struct aac_srb_unit instance "srbu" by the
only two callers, aac_issue_safw_bmic_identify() and
aac_get_safw_ciss_luns(), do not contain anything in srbu.srb.sgmap.sg, and
they both implicitly initialize srbu.srb.sgmap.count to 0 during
memset(). For example:

        memset(&srbu, 0, sizeof(struct aac_srb_unit));

        srbcmd = &srbu.srb;
        srbcmd->flags   = cpu_to_le32(SRB_DataIn);
        srbcmd->cdb[0]  = CISS_REPORT_PHYSICAL_LUNS;
        srbcmd->cdb[1]  = 2; /* extended reporting */
        srbcmd->cdb[8]  = (u8)(datasize >> 8);
        srbcmd->cdb[9]  = (u8)(datasize);

        rcode = aac_send_safw_bmic_cmd(dev, &srbu, phys_luns, datasize);

During aac_send_safw_bmic_cmd(), a separate srb is mapped into DMA, and has
srbu.srb copied into it:

        srb = fib_data(fibptr);
        memcpy(srb, &srbu->srb, sizeof(struct aac_srb));

Only then is srb.sgmap.count written and srb->sg populated:

        srb->count              = cpu_to_le32(xfer_len);

        sg64 = (struct sgmap64 *)&srb->sg;
        sg64->count             = cpu_to_le32(1);
        sg64->sg[0].addr[1]     = cpu_to_le32(upper_32_bits(addr));
        sg64->sg[0].addr[0]     = cpu_to_le32(lower_32_bits(addr));
        sg64->sg[0].count       = cpu_to_le32(xfer_len);

But this is happening in the DMA memory, not in srbu.srb. An attempt to
copy the changes back to srbu does happen:

        /*
         * Copy the updated data for other dumping or other usage if
         * needed
         */
        memcpy(&srbu->srb, srb, sizeof(struct aac_srb));

But this was never correct: the sg64 (3 u32s) overlap of srb.sg (2 u32s)
always meant that srbu.srb would have held truncated information and any
attempt to walk srbu.srb.sg.sg based on the value of srbu.srb.sg.count
would result in attempting to parse past the end of srbu.srb.sg.sg[0] into
srbu.srb_reply.

After getting a reply from hardware, the reply is copied into
srbu.srb_reply:

        srb_reply = (struct aac_srb_reply *)fib_data(fibptr);
        memcpy(&srbu->srb_reply, srb_reply, sizeof(struct aac_srb_reply));

This has always been fixed-size, so there's no issue here. It is worth
noting that the two callers _never check_ srbu contents -- neither
srbu.srb nor srbu.srb_reply is examined. (They depend on the mapped
xfer_buf instead.)

Therefore, the ordering of members in struct aac_srb_unit does not matter,
and the flexible array member can moved to the end.

(Additionally, the two memcpy()s that update srbu could be entirely
removed as they are never consumed, but I left that as-is.)

Signed-off-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20240711215739.208776-1-kees@kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aacraid/aacraid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 7d5a155073c62..9b66fa29fb05c 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -2029,8 +2029,8 @@ struct aac_srb_reply
 };
 
 struct aac_srb_unit {
-	struct aac_srb		srb;
 	struct aac_srb_reply	srb_reply;
+	struct aac_srb		srb;
 };
 
 /*
-- 
2.43.0


