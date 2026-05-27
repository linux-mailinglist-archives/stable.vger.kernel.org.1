Return-Path: <stable+bounces-254574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAHGDBHgFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:14:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C895E3F4F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC9DE300BC97
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9B73D1CB5;
	Wed, 27 May 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gomQd0WN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F6357D03;
	Wed, 27 May 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883908; cv=none; b=TTALiTGgja5wqkD3OMrlzfr6xsIX+nNbK8ypTIpbT2OTerSyRaisWLFwnNC28cpy+oAjSOfxcgQYgp7IJG5e20ggz7i3Y1hie25brQoB91qO7Pmgo+SBgCjxnYd/WYiquutyWmuUgqOuCZVDVGbBGclh6zXi91dX14O5BnPbdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883908; c=relaxed/simple;
	bh=tPlJqcume+JNEKRIQ9mOX2AK2+MgtYcG33f98oc7O1g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uWOcXytNS5RUrHX+iZZQV4QcdUwmFlz4drE4IdnPX0qNLnFnuCTQUecDsFAItYFr9q/sz46p6Ocx5VU7ecTq8NgEHLhQ5p4EN9ogcB55xMAOcOz8Nm71FTdxO/wMEMnt9Pzn1LzbTEdFkhE9GsYXTPnL5fFtZviNTuIdNRDzKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gomQd0WN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEED1F00A3C;
	Wed, 27 May 2026 12:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883906;
	bh=7TcNBqLYcIMZDMleDzmiF96Uwe0hmTDmIYoduoxcsxA=;
	h=From:Subject:Date:To:Cc;
	b=gomQd0WNf0u2ufCJlLVojHfgaTBa7J7bpHgr9xvUAfHzBimNvdh92/uGuSNyFTArp
	 unuxnlf/2o34VGScIEaVwo53m1Hu05KXS2qisGHjLZ+fmDjX92vNU67h7nyq6vqm2O
	 KtgVxPgrPMWwN4CrtXCfPpWsgRvPbUcVRuRURkrUS5HEbozC2wNgPG40RtGtDH7nEZ
	 IeyjIC1KCY+LxqZQc71w4hgdurT9PNCuHUiPb4QV3zqJO8/9vovOuKAO8BiMQkvtq8
	 14wrZF2QhsH9Mp7xOIqqzwSpWGxIJdzHJqfVoqmoxQedsPklctglsoLzzDLxO6Ztt2
	 9GUtZ/RbKcxag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] selftests: mptcp: reduce bufferbloat and cleanup
Date: Wed, 27 May 2026 22:11:33 +1000
Message-Id: <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBBFr1Jm7UAabLVeRbpI0omOaBoyUymU3
 t2oy/fgv7+BUGESuDQbFHqz8JwqtIcGwt2lGyFPlcEa25vOnjCR4itryChR0S8xUvHP2SnSyop
 n0w3t0Lsp0BFqJBeKvP4OrlC3MP6lLP5BQb9p2PcPRbWQSocAAAA=
X-Change-ID: 20260527-net-mptcp-sft-bufferbloat-exit-8059196adce4
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tPlJqcume+JNEKRIQ9mOX2AK2+MgtYcG33f98oc7O1g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqFt99Ab/roHqzzKUY66oJmPFt5cD2qZ1gtq06c
 ow09CpuXjKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahbffQAKCRD2t4JPQmmg
 c4nDEADOh3xX3WJvLGWbvRG1rysMBA9xNlykYy/pus5cf9WlwGDNN163hcR0Ccry9tNIFg1rour
 M3jE2vF1C0nozDo9RiIzgyWYchZulgqOBV5w/dnII6bUB2uUQK0FB/xFL8rAfSM5Hn/8H6dWxKh
 HQyhwzbd7QepdH8XWjU7bbsK6A+b8ORStVT+W8g/voFxBojiYTgdJFa/kGpiyAVYCwAD70GhrVw
 8jjXojzep6Cm2FfM6kQA9Kuyuv8VVbKaAnkuWLyOCi8aNX/Lfyt/vPEv3odkV7GuuV7jSb/Wk9q
 7+mgSVUwDQWfSf/Ohi6Lf7wUnTkuvK7DUvKWhOyM3gXUAEyfia3raa2La2BUObOWZfApqxOgViG
 fIdirVnCeoQdsxNR4AcsmGR2q45fC9pAOuBHHidNB9Zo8qSYW451i8HTOrBjYjsHjq6T+DJfUrR
 P/P+BKPphhmUBnmdoMBCCKGW78OH5ArF9ayrTETJzS/L4UeVj6gZsXKXfhEtfteCU8yvhxe/wFS
 GXulDFffIc+DgOBKmCH18rM9sUbEBQe6Od5asiBy+TkM0lis3fmopuKaFnKkJmKfAHYF1e5hXwQ
 QvRcT40ubXwGJNx3YZIB7iU0iqqonPr85TPIYem4bYGtay9ZAYUhA2U/s+BbJ0FvzhosTtiRYf0
 l62THPOfDJAmmHg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254574-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 70C895E3F4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bufferbloat is baaaad, even in our selftests: let's kill it (or at least
reduce it). By doing that, the tests (seem to) have a more stable
transfer, and are then less unstable. That's what patches 1-2 are doing,
and they can be backported up to 5.10.

Patch 3 is not related: a small fix in the selftests to remove temp
files that were not deleted in some conditions, since v5.13.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      selftests: mptcp: sockopt: set EXIT trap earlier

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: simult_flows: disable GSO
      selftests: mptcp: simult_flows: adapt limits

 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 34 ++++++++++++----------
 2 files changed, 19 insertions(+), 17 deletions(-)
---
base-commit: dd433671fef381fdaf7b530c631e6b782d66e224
change-id: 20260527-net-mptcp-sft-bufferbloat-exit-8059196adce4

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


