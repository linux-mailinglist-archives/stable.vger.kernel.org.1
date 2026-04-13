Return-Path: <stable+bounces-237527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MdVKx0j3WkoaQkAu9opvQ
	(envelope-from <stable+bounces-237527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D983F0D3B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B08473069149
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF54346E78;
	Mon, 13 Apr 2026 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dnLXEIyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1D33EB17;
	Mon, 13 Apr 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099686; cv=none; b=C+sOsqu8FM8o7mqphjw7Nr+j8RWWK+5NTMW/Qww1qTPnY2WWJvm96CBwBndIqb5UQH7gEW8kKi5XvsoYDMYeLWkCE3WvqKQc0/3QPvco0UWw66906HuR7jY7yjlZYShXeOcHfasdbBty3TmGlbr2z/zpdzdEs/J/JVPfbfL4CJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099686; c=relaxed/simple;
	bh=iCjaUugmerTOq7+ik1I5SXb6QWYHdtu+PsU1BXn5Eu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO9dRVDidu+TWXtpLqE/GS17SbP4A91YuDHqEuFTsPQuMHKLTXZTn44KvT7sfANvWEweranFzwbLQ0Wac6ZDRqWo6VvO/bPBNEgb4H0t+Ytv4XR/4Y0Z2YRCI1KDCvseXrQShvEU/Y7wbnYvLctEGIXL6Pvj2xLaK5B5pwGq+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dnLXEIyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659F0C2BCAF;
	Mon, 13 Apr 2026 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099686;
	bh=iCjaUugmerTOq7+ik1I5SXb6QWYHdtu+PsU1BXn5Eu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnLXEIyNBDCmh7Ah2y8ekwkStbZ1O1cT9yVypK7jxCnnz5IuEA7NBryv5ugs9OkxP
	 DnX/FXHse2246LQmxW3BMPW9AfBMiL3duZkHCbxVoayVZYBZdWjbwRQ+twerTyOR+7
	 VhcU6LUrXxZhBHiCN0PgKrgS3NppwqvzlF8CzdzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 5.10 436/491] apparmor: Fix double free of ns_name in aa_replace_profiles()
Date: Mon, 13 Apr 2026 18:01:21 +0200
Message-ID: <20260413155835.351024608@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237527-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualys.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,canonical.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57D983F0D3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 5df0c44e8f5f619d3beb871207aded7c78414502 upstream.

if ns_name is NULL after
1071         error = aa_unpack(udata, &lh, &ns_name);

and if ent->ns_name contains an ns_name in
1089                 } else if (ent->ns_name) {

then ns_name is assigned the ent->ns_name
1095                         ns_name = ent->ns_name;

however ent->ns_name is freed at
1262                 aa_load_ent_free(ent);

and then again when freeing ns_name at
1270         kfree(ns_name);

Fix this by NULLing out ent->ns_name after it is transferred to ns_name

Fixes: 145a0ef21c8e9 ("apparmor: fix blob compression when ns is forced on a policy load
")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/policy.c |    1 +
 1 file changed, 1 insertion(+)

--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -917,6 +917,7 @@ ssize_t aa_replace_profiles(struct aa_ns
 				goto fail;
 			}
 			ns_name = ent->ns_name;
+			ent->ns_name = NULL;
 		} else
 			count++;
 	}



