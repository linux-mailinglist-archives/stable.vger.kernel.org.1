Return-Path: <stable+bounces-114803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60298A300BE
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791F33A662E
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C51E5B7B;
	Tue, 11 Feb 2025 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7uC2ajm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09B2206B5;
	Tue, 11 Feb 2025 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237534; cv=none; b=o72RaTtQJT9Pnrp2F7On9rjoV4tPpXzY3quLfDlQlLSBxoQ5jW35Bmj6EX5YlJQ946VtDwAAw4DeHM3E/VHK8tOXNNA7snGSrj7SomAu4JCYGdPZxx1YdA5WeJMd67V4xXaiWu/7UqOXPQv4H3Jsxm+EpwdqCDbKigmGS3nUJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237534; c=relaxed/simple;
	bh=iiOkryXmhkldJUUdUWPMeYG3VZWIaMZDxkZthCW/oSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wbqg39PPV6UFfTEu5Q60jtnh+5N35n+pTVB59Gf2+qSPQ/EOtY0oZJWZQGo5xQho0+39f6DnmlKzW7fAoIzvHNf90w5Qt0T5n4l3NYTOGMoe6N1HUfxU3Fe0EAJ+Vm+mEH1iJY80mo+hUi24Q+4r9ebJqgX7bDZkXqpGJvUIUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7uC2ajm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0043C4CED1;
	Tue, 11 Feb 2025 01:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237533;
	bh=iiOkryXmhkldJUUdUWPMeYG3VZWIaMZDxkZthCW/oSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7uC2ajm/JI2uqKI0id4g+oRZHOIjtbKYxEqu6YtE+vmLU7wgbBHOAc0KqLQxlAcj
	 wbkIqS9LbrVP34HADYh7YJImSvde8AcxbsOMzfm6KOL5+eXulwZ5NNPkl6iGB3CUt/
	 LiZFEFttJ4QruuainSenBhMmji4CggYAKz5sW/dfg28rbjGp6TIiyM0HFhnRRpO86Q
	 Zc0DU6U80k77D8r7K+JdVbwCt4pkz5BhOzmRmPy0BO70jIq+4aiY1qrn8eHh+ZvUgW
	 ZSPZjO1D5vNJP9igRcpiI3/oBHTpHZh9pTtUpx4IeUcf5YRcxb+KQ1DGqgyMrTkFCT
	 Hh76oUoOOrzEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chengen Du <chengen.du@canonical.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	pjones@redhat.com,
	konrad@kernel.org
Subject: [PATCH AUTOSEL 6.1 04/11] iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()
Date: Mon, 10 Feb 2025 20:31:59 -0500
Message-Id: <20250211013206.4098522-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013206.4098522-1-sashal@kernel.org>
References: <20250211013206.4098522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
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


