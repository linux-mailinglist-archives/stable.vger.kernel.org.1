Return-Path: <stable+bounces-114814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86521A300D9
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA37818855B8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0A25380D;
	Tue, 11 Feb 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOg/ZPR0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0262253805;
	Tue, 11 Feb 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237556; cv=none; b=cjmCNKG6HGdEN8mSIqIPdTnr0cxcODwZbEzgP9q/O9uvFAhY0FB+nA/qxWry6YBQONh1fanbDDAR5E91J9hID5Q9D6rDDLecWVareNoG3K3dAKRktw2YzTq4fbwzAUX54q5zIbIVKaiviiy6hrdPK8LXLSYPa97l8/K0BQ3zasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237556; c=relaxed/simple;
	bh=iiOkryXmhkldJUUdUWPMeYG3VZWIaMZDxkZthCW/oSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jg6hI3CVfRAVXeFCCdQ/23TBpiVsgdEG/tbe14q2KkR0+GxcC9CGb9i2WvM6JbqB5nkbon6U9MOHqWZdeQnYewNHqhr60tr65mt5s6yxgoQS6Dj2vvirv3yh8WoZ5hQAkS1EVjHCAnwrB34Qjz4GCYJH3ZhymUUJVtYIc1sFKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOg/ZPR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38EFC4CED1;
	Tue, 11 Feb 2025 01:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237556;
	bh=iiOkryXmhkldJUUdUWPMeYG3VZWIaMZDxkZthCW/oSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOg/ZPR0GcaFm6+UZ4mPzc/NT7yyGG1HtoVyY9DbkOrO6QF7KjdTgJffbj3/fdCX9
	 f6eByJPpFe+lXG+feTpb0KlQt06embhpfO/NlgCzc2SpgI1OVYiKbZDRcrxvVSDjC1
	 OrakVYJgFm1hNQXQClijJly3UuL1fQNVpo7/Bgm1+9XYCDWvVf2C3sLWYA3k7AyxeJ
	 kYb6OghskTftPdGGdZaAS0Ny4WC1G5gSHyx1MnQaYsOINUIS4ErcQHRkiWfZmxPaIX
	 Y1Z1jrotQVcYX+DCmXvyEwmmuWv8x9GCL4JRs+77d6aefqe0YyonW6cfzq31xD2Daq
	 emb77Y9DMoHvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chengen Du <chengen.du@canonical.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	pjones@redhat.com,
	konrad@kernel.org
Subject: [PATCH AUTOSEL 5.15 4/9] iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()
Date: Mon, 10 Feb 2025 20:32:25 -0500
Message-Id: <20250211013230.4098681-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013230.4098681-1-sashal@kernel.org>
References: <20250211013230.4098681-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit

From: Chengen Du <chengen.du@canonical.com>

[ Upstream commit 07e0d99a2f701123ad3104c0f1a1e66bce74d6e5 ]

When performing an iSCSI boot using IPv6, iscsistart still reads the
/sys/firmware/ibft/ethernetX/subnet-mask entry. Since the IPv6 prefix
length is 64, this causes the shift exponent to become negative,
triggering a UBSAN warning. As the concept of a subnet mask does not
apply to IPv6, the value is set to ~0 to suppress the warning message.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/iscsi_ibft.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 6e9788324fea5..371f24569b3b2 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -310,7 +310,10 @@ static ssize_t ibft_attr_show_nic(void *data, int type, char *buf)
 		str += sprintf_ipaddr(str, nic->ip_addr);
 		break;
 	case ISCSI_BOOT_ETH_SUBNET_MASK:
-		val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
+		if (nic->subnet_mask_prefix > 32)
+			val = cpu_to_be32(~0);
+		else
+			val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
 		str += sprintf(str, "%pI4", &val);
 		break;
 	case ISCSI_BOOT_ETH_PREFIX_LEN:
-- 
2.39.5


