Return-Path: <stable+bounces-226739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGZhO4uUuWnKKgIAu9opvQ
	(envelope-from <stable+bounces-226739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:51:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B132B03AC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3111C3265D4D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8132548B;
	Tue, 17 Mar 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2iPZNTF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E92FD69D
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768002; cv=none; b=DHcPRLjyGZ1GQvZ8kBd0Qudpo7jFoc1kzF23RfCTLX+azi+L1iNKNgOOaRyHbKu4XLo+WrDYemelO/kh2KpH6lnYIBTRyFbPgH98vu4C83xmWRAAisPEgsKVYLaUy7uwq/0cwx35QpppEkyoy5HtuhK4sPUKxuNmOZ4wWnl+3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768002; c=relaxed/simple;
	bh=p2pht/J8eIhSN3Ur2kmmm0ZxQQwbBB3AYY0fVZHj4PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWzC3q8Cn713E3gyxIMmoQCm1aKE1EK/1bfNITSEi3lZl+YiOUnBO3OkxIcGezXdERjrFkyTwuxfAgePmYl6FC+OriAn8CYOZbp+YcQ3GVTX3W/jSuS7vsxXQHYorVTWe6X7DKMojknXwCxTiS0OflaZVPyE2Nsf52GGqddhZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2iPZNTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F8FC2BC86;
	Tue, 17 Mar 2026 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768002;
	bh=p2pht/J8eIhSN3Ur2kmmm0ZxQQwbBB3AYY0fVZHj4PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2iPZNTFZD9dMtHYuC0tog+tN+LE+K41QawP5/Zdqp+Jo3hFtMRkXPa/gwewCopyu
	 pcFtHICsV145w/k5lY39PHIQqifdUygoTZvcM7yZlSLClnAXDjbSzNwle9KoUVbRzw
	 BkETgAF/TRDGsbP+SAnNIIQ/2Lk7d5dorqRKrQMLgz5/isDCpBthymzTbHgeLxMezw
	 f79M9tZ9HoUzuouoGzrFFnbeaPqZbKTMb5eaH6TH/318wgclINTJFWQH7l9eBDowd/
	 9hGwbFJRfYuZYs2D3nrg6yTRh5z3bX526zBGbPlbR4OjSZ2aZJk23Wu0cO8l1RUMsK
	 7FitPssZfTFRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/8] device property: Check fwnode->secondary when finding properties
Date: Tue, 17 Mar 2026 13:19:52 -0400
Message-ID: <20260317171954.238398-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317171954.238398-1-sashal@kernel.org>
References: <2026031703-caravan-bladder-c63a@gregkh>
 <20260317171954.238398-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,redhat.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226739-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 82B132B03AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Daniel Scally <djrscally@gmail.com>

[ Upstream commit c097af1d0a8483b44fa30e86b311991d76b6ae67 ]

fwnode_property_get_reference_args() searches for named properties
against a fwnode_handle, but these could instead be against the fwnode's
secondary. If the property isn't found against the primary, check the
secondary to see if it's there instead.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
Link: https://lore.kernel.org/r/20211128232455.39332-1-djrscally@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index bf9673fe59b3b..7de58f4887860 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -479,8 +479,17 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args)
 {
-	return fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
-				  nargs, index, args);
+	int ret;
+
+	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
+				 nargs, index, args);
+
+	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
+	    !IS_ERR_OR_NULL(fwnode->secondary))
+		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
+					 prop, nargs_prop, nargs, index, args);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
-- 
2.51.0


