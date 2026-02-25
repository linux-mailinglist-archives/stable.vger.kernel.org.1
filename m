Return-Path: <stable+bounces-218682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFG5JXlYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B94190727
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EE1430E6C9E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C07326CE1A;
	Wed, 25 Feb 2026 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nBgx+m5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7125A655;
	Wed, 25 Feb 2026 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983539; cv=none; b=poDTZ/hJ3mCVdYrCIMoePZ2SYfOTUM71GOT0egiE/jYIYpsybd4JL7KXvzaTkzSyvfQiYrJtBNbVnSfuSSN6srOibvRQ0Xq237zpatfzBqTTp0MpsHhxL41DWHJizeGfRK8PMkuSFFFVxgs0/dXGPjYB5v9uMh8Ofux6APQ6xtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983539; c=relaxed/simple;
	bh=99jMZrr6yrfDHYCyqa8IEFWqLxIeUN4x20CcYSAOscI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py3bVnxiRdmpP2QJ4buQ3eNDwknD6SX/pH365d6tlVALuZvoO9KLI1ilxyABClsBzQZS7mlPJa+qzXcc0LA+yv0+7ZQ/vkVN0dQhI2bRROHRYN8DD3FWMp14wTJXOUeWIe4L8K0IH0y9jhhP8AxOsxj2mI9HaXK6ZAaU+dgLLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nBgx+m5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F8FC116D0;
	Wed, 25 Feb 2026 01:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983539;
	bh=99jMZrr6yrfDHYCyqa8IEFWqLxIeUN4x20CcYSAOscI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBgx+m5wi3Zz6pG7GgFmb8Mhfg/MYgPS+Qy8NcYW9ISlFBIoa4BJ4f1S24w9E4C+W
	 d2FTPfpMWZBjvcvyS/y6v6SsEEnJ+R//U9fwz7y0N5016fNNKJMVTxSpGsntDIKVN9
	 t5kwqkg4bRupUpe6N1RGPLxYqTE/V8DBULkU5If8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pin-yen Lin <treapking@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 643/781] selftests: netconsole: Increase port listening timeout
Date: Tue, 24 Feb 2026 17:22:32 -0800
Message-ID: <20260225012415.572890363@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218682-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netcons_basic.sh:url]
X-Rspamd-Queue-Id: 20B94190727
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pin-yen Lin <treapking@google.com>

[ Upstream commit a68a9bd086c2822d0c629443bd16ad1317afe501 ]

wait_for_port() can wait up to 2 seconds with the sleep and the polling
in wait_local_port_listen() combined. So, in netcons_basic.sh, the socat
process could die before the test writes to the netconsole.

Increase the timeout to 3 seconds to make netcons_basic.sh pass
consistently.

Fixes: 3dc6c76391cb ("selftests: net: Add IPv6 support to netconsole basic tests")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260210005939.3230550-1-treapking@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index ae8abff4be409..64d3941576d5d 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -247,8 +247,8 @@ function listen_port_and_save_to() {
 		SOCAT_MODE="UDP6-LISTEN"
 	fi
 
-	# Just wait for 2 seconds
-	timeout 2 ip netns exec "${NAMESPACE}" \
+	# Just wait for 3 seconds
+	timeout 3 ip netns exec "${NAMESPACE}" \
 		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}" 2> /dev/null
 }
 
-- 
2.51.0




