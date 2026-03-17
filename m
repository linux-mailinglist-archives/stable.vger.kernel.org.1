Return-Path: <stable+bounces-226521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBuKAL2PuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676922AFB78
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCB4A315AFCE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B888D357A4A;
	Tue, 17 Mar 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mjxa/uI7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EE2FFDEA;
	Tue, 17 Mar 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767069; cv=none; b=s6FA8xe6RoX1IcfHat6x38tlBPMDGmqHI0c9hftA/SHciWtWNRDB4vwu8SHH0Lr3eLZNfGS/42vczxkeomVsfsAXa/ey3i5EYHguGtdkXdMe5bck1P4VoRV9YwCxN90LXPZv4frNtKsEvV8UTMNH1AlttPiRQfVoQcA3UZkFozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767069; c=relaxed/simple;
	bh=qr4jz1e+eIMpGqOy1yNIsuymEUrME5D+B8yAXXaKDWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTwZZzkTt7VvAJkBtSb8A71uPWf7EQfYWML7wUwnZc75G9LYrpX/V5P6K+t1WUrTqZEGGuxlE7pofF1sUPVfaCRoEUvuQcIcxcsvos8sHbmz+JLLDly0XDz2+DvEahSmIc7kZJgRl/37rZINGonyWFunnAdNmADIIflgWIN2wQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mjxa/uI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8338BC19424;
	Tue, 17 Mar 2026 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767069;
	bh=qr4jz1e+eIMpGqOy1yNIsuymEUrME5D+B8yAXXaKDWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjxa/uI7sdiDOzDRZIluG85glZlabd5J8LRgEu5zj8TVaKT1ypRsSo3Wohcr0KKoz
	 usOCUDDyk14J7GCk9RYhcwWKIk+Mw7AqjiBS2SqWnXZ/W7oGm2nitqVyxeQZRX3kYw
	 t9PkAOSdKCn1edNpsFKttZe13S8lbBF2UXxjfnmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 373/378] mm/damon/core: disallow non-power of two min_region_sz
Date: Tue, 17 Mar 2026 17:35:30 +0100
Message-ID: <20260317163020.702207146@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226521-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 676922AFB78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

[ Upstream commit c80f46ac228b48403866d65391ad09bdf0e8562a ]

DAMON core uses min_region_sz parameter value as the DAMON region
alignment.  The alignment is made using ALIGN() and ALIGN_DOWN(), which
support only the power of two alignments.  But DAMON core API callers can
set min_region_sz to an arbitrary number.  Users can also set it
indirectly, using addr_unit.

When the alignment is not properly set, DAMON behavior becomes difficult
to expect and understand, makes it effectively broken.  It doesn't cause a
kernel crash-like significant issue, though.

Fix the issue by disallowing min_region_sz input that is not a power of
two.  Add the check to damon_commit_ctx(), as all DAMON API callers who
set min_region_sz uses the function.

This can be a sort of behavioral change, but it does not break users, for
the following reasons.  As the symptom is making DAMON effectively broken,
it is not reasonable to believe there are real use cases of non-power of
two min_region_sz.  There is no known use case or issue reports from the
setup, either.

In future, if we find real use cases of non-power of two alignments and we
can support it with low enough overhead, we can consider moving the
restriction.  But, for now, simply disallowing the corner case should be
good enough as a hot fix.

Link: https://lkml.kernel.org/r/20260214214124.87689-1-sj@kernel.org
Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>
Cc: <stable@vger.kernel.org>	[6.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1241,6 +1241,9 @@ int damon_commit_ctx(struct damon_ctx *d
 {
 	int err;
 
+	if (!is_power_of_2(src->min_region_sz))
+		return -EINVAL;
+
 	err = damon_commit_schemes(dst, src);
 	if (err)
 		return err;



