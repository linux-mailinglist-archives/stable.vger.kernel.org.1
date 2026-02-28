Return-Path: <stable+bounces-220850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOz5BcxEo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:41:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567EC1C73EA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2E433E1445
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDCB34FF7D;
	Sat, 28 Feb 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SITkB9kZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC741A277;
	Sat, 28 Feb 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300737; cv=none; b=YIb9cqVEOhCQtnEqr5XlEyunw1X9SVl79osQY2mopYS2omWWDRFoQ7ZpELyagWEvkHn6ATv7VT1yElmXfy3HtPSNVMpHonSQSas5gC8BYSFSFCUIMqz2/OcKdgSJEtzgolHFss72KBTxA608CMaQtZ7murmRjRaPp0gzrhBfpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300737; c=relaxed/simple;
	bh=emobCQBnMg46p/11boViFk59VezvSiUxF6K3V1JMj8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj+xn7uz1MKXKLJ5kEmoUHbXY9O0BUw7BsBcpX5TG5Zt/wgitvyL+BsSQtyt3IZFe1jiEYP786tJvW4df1c96WKBvGS9KFYI+fDJqTwKI9xIfUVZcJzEE+zVtemBj/kvdblTnF6Y37nbbz2wwGdQGYjkQ+836p6ACXlXuK3WhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SITkB9kZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2F7C19425;
	Sat, 28 Feb 2026 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300737;
	bh=emobCQBnMg46p/11boViFk59VezvSiUxF6K3V1JMj8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SITkB9kZv227NPqAQa/sxm5eiLPIWZq8SxqCHMKoDrcvIVc7HUu8yVYI/46OuvHKJ
	 QqLi5a1Klx6hf0r4X5KVZKK+1ajOSIzuXgvB4gKukYdjrVspK2psEquJMjmEOXu+8A
	 ySSXG8suyYeEMdZkZYP+yxmD+T6AVBhUBWLTrXm193vM74sYyApUYslg9ZlCCklQig
	 SE/b+cgG6dIgFgm4LfE8ffr0pxTb/vM61j3f4zbVUBOJN5phMGU95NleroEruCEySX
	 qyaJkkZk1qBTtSkVzJDv1y7oPw931IKgOfI3GFWOHQxRnO7zpODgtZvlhireXlwdK9
	 Wj8DnLjvmvfbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 771/844] LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Sat, 28 Feb 2026 12:31:24 -0500
Message-ID: <20260228173244.1509663-772-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220850-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,loongson.cn:email]
X-Rspamd-Queue-Id: 567EC1C73EA
X-Rspamd-Action: no action

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit 94b0c831eda778ae9e4f2164a8b3de485d8977bb ]

The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE -
which is a valid index - so add a check for this.

Cc: stable@vger.kernel.org
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
index f06e7ff25bb7c..6b79d6183085a 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -12,7 +12,7 @@
 
 extern cpumask_t cpus_on_node[];
 
-#define cpumask_of_node(node)  (&cpus_on_node[node])
+#define cpumask_of_node(node)  ((node) == NUMA_NO_NODE ? cpu_all_mask : &cpus_on_node[node])
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
-- 
2.51.0


