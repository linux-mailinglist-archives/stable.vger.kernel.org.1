Return-Path: <stable+bounces-210841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHAyNRQtcWl1fAAAu9opvQ
	(envelope-from <stable+bounces-210841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:46:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2BC5C794
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18945805867
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADB137F109;
	Wed, 21 Jan 2026 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l1Ttcfnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0F3382D3;
	Wed, 21 Jan 2026 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019563; cv=none; b=BaOETf4TJwcaaXI3NfWeblyjatffc4mJz7o5AAw3G+wQcSvyd9nguL9qMl5CrmMX3QVr9j23pGLgi9K5Mqyuj2uw2iLj3/+iT0KLlkBo/lCxA8HWQFuNqAjS/NHRjqgQnNqGimSdoG+ZslJJxIcpLgDhILeQ4zn+kkPqEo11yVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019563; c=relaxed/simple;
	bh=/4afqFWWwrRT+dLH+r8APZeAIgCIbDBBnLQw9aztsDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyvmduiKZuuel4M4rgDOjV9d4lr2/1XwiAPHJrJwBq5nMJSVixg5bbj2zOY4eHuLK+ArRF56jwDzPNv6sHAPEgW/yhvZX9Th8yxLww8BQULdxaSmzo0Ryrd7L60Dux0aDc2go9OkRRc9zvU7lmGYBKPS65pYK32tMuw042wnxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l1Ttcfnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139FAC4CEF1;
	Wed, 21 Jan 2026 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019563;
	bh=/4afqFWWwrRT+dLH+r8APZeAIgCIbDBBnLQw9aztsDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1TtcfnvkaTTXVU+H3+WWbF/ygNXlEJ8LTSi1ISPR+btKXDjqG7gV4X5Mny4puCbS
	 H+P1SXZEnsQkZPz4OrpTTkmSNy92/ooYjhORWzLX6ojLjKpXWqdl36nrz4uDc+moNH
	 dAHKowEoDNMVZYrnFRILeXRwOzpuJ7VM1/gQD4Rc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Thomas Graf <tgraf@suug.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 042/139] textsearch: describe @list member in ts_ops search
Date: Wed, 21 Jan 2026 19:14:50 +0100
Message-ID: <20260121181412.968993061@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suug.ch,davemloft.net,linux-foundation.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210841-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suug.ch:email]
X-Rspamd-Queue-Id: 8B2BC5C794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bagas Sanjaya <bagasdotme@gmail.com>

[ Upstream commit f26528478bb102c28e7ac0cbfc8ec8185afdafc7 ]

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/textsearch.h:49 struct member 'list' not described in 'ts_ops'

Describe @list member to fix it.

Link: https://lkml.kernel.org/r/20251219014006.16328-4-bagasdotme@gmail.com
Fixes: 2de4ff7bd658 ("[LIB]: Textsearch infrastructure.")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/textsearch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
index 6673e4d4ac2e1..4933777404d61 100644
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -35,6 +35,7 @@ struct ts_state
  * @get_pattern: return head of pattern
  * @get_pattern_len: return length of pattern
  * @owner: module reference to algorithm
+ * @list: list to search
  */
 struct ts_ops
 {
-- 
2.51.0




