Return-Path: <stable+bounces-254668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LcCBPBKF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2B5E9AC2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF899306E193
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6323B19CD;
	Wed, 27 May 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci8UlVH0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621913B27C2;
	Wed, 27 May 2026 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911363; cv=none; b=uc187ijm/H3R/UoXtZd0kyMv//a9p4VCehEB3J6HuoPXSAkeQ6QQt6IKFSPA7qZ+fqCrm4Xo8x5V2BFs0IuiQUJi22oN87opQ0j3Td3vnw503r3bfjX13YPWvvwc4Qq9i3fqPe4RvVzOYlEprJzlg0bxYzPO3xpz9jV30gEiRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911363; c=relaxed/simple;
	bh=1GFfPNR5K34gDyccJH/hSIhUrEjCFbGPHELgs2rqU44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmGVE4VKx239ltTGqsrpy7vQQaxeat2/n8wybfRPmhZt3EcHu10bE6vBhx7BpV2JEW5wsT9q2pk91Kv0287vPBwVyRv8SKmYPLHOMXYE1YR/vocDCJtVMafhWQUuTF4TSrSdZp65osGoXG6HJXWaIvoM/2c6e2mQ+LsR6lciYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci8UlVH0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1BE1F00A3D;
	Wed, 27 May 2026 19:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911362;
	bh=1GFfPNR5K34gDyccJH/hSIhUrEjCFbGPHELgs2rqU44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ci8UlVH0D8ctwOmqPf9iErVsJtcmpmp2+xkGub1np0wYMb1DvtNluZl3+XMNix82E
	 29FBzqixqwdpGleXJLfCNHnQREZUJSVtPTYRn1WmNBBOjXQ3LLTt4u/vpvdqOGeWCy
	 jJbuJMV7oBijpBXro2k9aEEmvrgJXmveTivEjuJEApht6nxP1WXD54IJS1X3wu80I/
	 I46tcEUqSbf8Z1UniY9LB0bJwpFdgW4++PwT7wNPmvfWIgVf+EcxVLntdlo9QcTh3w
	 bJabMt7Kieu2bLiGTsk2JcIXsXQ+1q8t4wLXbrR0tI2o3jU5BnTOf9JuRpo+GDkJoZ
	 Bhm1IDtKo2eGA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	bird@lzu.edu.cn,
	kuba@kernel.org,
	kuniyu@google.com,
	n05ec@lzu.edu.cn,
	patches@lists.linux.dev,
	stable@kernel.org,
	stable@vger.kernel.org,
	tomapufckgml@gmail.com,
	wangjiexun2025@gmail.com,
	yifanwucs@gmail.com,
	yuantan098@gmail.com
Subject: Re: [PATCH 6.6 229/474] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Wed, 27 May 2026 15:49:00 -0400
Message-ID: <20260527-agent5-item007-afunix@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527094544.2344825-1-guanwentao@uniontech.com>
References: <20260515154719.961677988@linuxfoundation.org> <20260527094544.2344825-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254668-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lzu.edu.cn,google.com,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 95E2B5E9AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On patch review, found this patch which backport to 6.6 context seems such
> different than orginal patch, I think this should be revert:
> commit 0d7e7235bc543c6ed7b873e3015db814d8e8c414
> ("af_unix: Reject SIOCATMARK on non-stream sockets").
> pls review.
>
> [DIFFERENT]:
> original patch patched in unix_ioctl(),
> this patch in 6.6 patched in unix_stream_read_generic().

Good catch, thanks. Reverted on pending-6.6.

No corrected backport is needed on 6.6: the upstream fix
d119775f2bad targets the SIOCATMARK path in unix_ioctl(), and the
prerequisite that introduces unix_ioctl()'s SIOCATMARK handling
(314001f0bf92 "af_unix: Add OOB support") is not present on 6.6.
With 0d7e7235bc54 reverted, 6.6 is back in the correct state.

--
Thanks,
Sasha

