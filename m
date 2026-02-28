Return-Path: <stable+bounces-220775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDwLCLFBo2lC+wQAu9opvQ
	(envelope-from <stable+bounces-220775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E711C7049
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 681BA3008523
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17FC409694;
	Sat, 28 Feb 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n419y3Cz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BD40968B;
	Sat, 28 Feb 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300654; cv=none; b=U+R3Gc7JnbvrStdzjo2h41rFf2Tw9EoXe6+goMhAntuCl29TKv5jSgD+lbEmY4wx+PPwxJZf1PTaOwY4BjM1dUTDBDld7DE3i94iCmFKl4vGNNjhzvynN1/wpaO74mdLBnYofuYRZnUUC2SzUMuSfj0LZDjtzSN0+bO5SuY2hmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300654; c=relaxed/simple;
	bh=yxA5KaE4uvfBQpQprwMxjBhIEAzroIjNlZjVW68MtJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kht961biiP+Xn8l97aapm9naGsDCT1VrZCJEIueFFB0EDZAjNGbcp9K3cgm4x5Bu5jlwhP0m0WeV21dgLQ7IzgBRaHLyapp5gGdDxzCf3sT+HX8PbTfvBRmB5NhvF+a+/pHcDG+Ua+wlggThBM5D+0+a64OJn3wpFURRAmGv0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n419y3Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4481C19424;
	Sat, 28 Feb 2026 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300654;
	bh=yxA5KaE4uvfBQpQprwMxjBhIEAzroIjNlZjVW68MtJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n419y3Czown4UugM7far54u6lkWAob2g8bYcMLH7DKqi9NTrkenROFAFzZG32mwp4
	 nM7vwdoH8uv8XrPhQtiEhdbomYFpqd+TUl4RwzJOGaNfZLFJa6HYXkakC3jGctX5jv
	 wIVRdcwEVjwCS1srawKF3RpFBSQ3dJ5he2wCSxlGAUenbaQYVzLzB6cZEnSo3PIu/7
	 74eZKOC0T3h6V78Y37jvMvkZdib6cDaCb9G/m+kW1ogsQSvpsl57pYFJ+51DV0i9A5
	 m6c3+a6JK9fvsb6OXk8Zu84AAapP1mb/Mqorh2Dtr+ofmGNe7Cmw07NBN6GZHvahwm
	 na4r9JRoGT4LQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 696/844] nvmem: Drop OF node reference on nvmem_add_one_cell() failure
Date: Sat, 28 Feb 2026 12:30:09 -0500
Message-ID: <20260228173244.1509663-697-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220775-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:email,info.name:url,info.np:url]
X-Rspamd-Queue-Id: 87E711C7049
X-Rspamd-Action: no action

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit f397bc0781553d01b4cdba506c09334a31cb0ec5 ]

If nvmem_add_one_cell() failed, the ownership of "child" (or "info.np"),
thus its OF reference, is not passed further and function should clean
up by putting the reference it got via earlier of_node_get().  Note that
this is independent of references obtained via for_each_child_of_node()
loop.

Fixes: 50014d659617 ("nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260116170846.733558-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 387c88c552595..ff68fd5ad3d6f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -831,6 +831,7 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 		kfree(info.name);
 		if (ret) {
 			of_node_put(child);
+			of_node_put(info.np);
 			return ret;
 		}
 	}
-- 
2.51.0


