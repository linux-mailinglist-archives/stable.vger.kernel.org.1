Return-Path: <stable+bounces-267483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J/E4KKJ/NmohAgcAu9opvQ
	(envelope-from <stable+bounces-267483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:55:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6E06A8D27
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:55:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PsEIXqnj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267483-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267483-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76EB3011064
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF92391E52;
	Sat, 20 Jun 2026 11:55:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB3390C89;
	Sat, 20 Jun 2026 11:55:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956506; cv=none; b=uyrHASzQu2+L267OIWr+44J7XKSPkx6VpezsvrLYuuuX+9g8PhU5MVJ6sldlOQba+togIZ6P7cHTyh4VeJwqttStTqFTWPLXkcUV6MpdNoe75t+nlEsq2zl85rPOEW9w3xsBatB8qz7Camr1K9R4pZGhPh33fzpqr+O1PHXnhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956506; c=relaxed/simple;
	bh=jI3pjNiZUpnm/15FxIIxxHqyEwjuyajQANipOhaPPXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtN6f4HkOPor74E3JC/mmsN3CivZBLTpx3TmVCyEPVrS3qGY6cX6Bt7JNvZ4GaTMfaRBGB36Vfumpi6q8zYeMYwrMlqlCBp6Qw4MSQTo2BFo+YvG7XkDwjYZhVA0nr4EmAiCEA+/smwOoJVQ7ipglhHG2XtOmx/ZFqy7IWN6HBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsEIXqnj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D3B1F00A3A;
	Sat, 20 Jun 2026 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956505;
	bh=VTzyEbpsj67GSmHwMkKpZirmo3PjyW0vNzF73BEaW50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsEIXqnjdpnWqeCuKHtBCHHDLyRxZ7x75vCZAtJXF0gAdj2U5i2NythDWW1Eghk7j
	 x7v/Tvr9hEr45TeSmM7Z+NB6YoGLJeumIfTTIp/nyCmYe4/ZtOKCYtFCKRIk/3IRo2
	 8PqByrVF5+mp0YcBmtRStefjO/lmse4IZ6g/AZ3/DBq0m6CJNuARj9+3Qj/p/8VmXc
	 5/rt3okUbXCl6XKz4C3MI/cUbHbZpuWtRJ3QeZMQcPHcEiLaJfeZtO56p/f+vT5TE+
	 E4wafxX1RPdWSjtaa0O/+fx2fQSAeiPSY7uzGwhNFLimX+lSr30dwLvAuUQTjndVri
	 ikF4/ONFetS5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaosuo@gmail.com,
	iri@resnulli.us,
	jhs@mojatatu.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: Re: [PATCH v5.10 0/2] Fix CVE-2026-23204
Date: Sat, 20 Jun 2026 07:54:53 -0400
Message-ID: <20260619.0002.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
References: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267483-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiaosuo@gmail.com,m:iri@resnulli.us,m:jhs@mojatatu.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:shivani.agarwal@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com,resnulli.us,mojatatu.com,broadcom.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B6E06A8D27

> [PATCH v5.10 0/2] Fix CVE-2026-23204

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha

