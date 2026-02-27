Return-Path: <stable+bounces-219948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC+AJhiJoWmVuAQAu9opvQ
	(envelope-from <stable+bounces-219948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:07:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1F1B6ED2
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D1183050CBE
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE393A0E97;
	Fri, 27 Feb 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="WbTjrk/y"
X-Original-To: stable@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FEB3ECBE5
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194069; cv=none; b=rJwlvFTYl2oCBcvlzy/fa+LTvpc7HKaMl9llgOzDxuIa36jRxv00CTFsT8UNszELVuCEIOoM+OBf+GYrBD4WatPKqrpOnEziMMNpVegpTRyvN/w7VfNmFI/7i0wzVGUkBLpSwwiEzGaXBX7MBfYrj9p8PQU0IdFWoYN8gtuwq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194069; c=relaxed/simple;
	bh=jsxDa2cjEDGqNh6pk9vrCNSPq95Oixrv/Y//SByYdG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUISytWjxaxFN/2aZ076bI8qg/2ryCjc7BkfsgLSuUpX5db0P93wYXOkzd0wOWwhcDBHoaGIJXHOyLml6fBDoWawA1HfBIxJKkFCn2ReIcMOxjWRRAzwlPhtuYnYH9wmqT2LaAHBIPfL+7vNijFPSYdrjscsAgN3ukAUh9Chp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=WbTjrk/y; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1772194056; x=1772453256;
	bh=jsxDa2cjEDGqNh6pk9vrCNSPq95Oixrv/Y//SByYdG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WbTjrk/y+wxh3Gg85XeaF//KDSYmd9Sh09LP4btYjFMghKHCYXd0BwZYibqom2wLT
	 JdQhgLRll3OvnhVHhKdnfphAwQw7hhr80hzBxFCeONK7kAzUToItnhrmo/lSFmVTMU
	 prCVteE3pKFnUqrCGfdEcxpuOBAhS7rGwipevec4A/LJq9EsUdW6EJJtrXHmdhSDSW
	 apHgRoAIwCSJ+FSyEa0AyNx0NZ6voiWAqf8OiD4G/H7dA5ReWM7bBopH2fbG/94ODb
	 xRgPcLiOXqZVXUPrLYIFtmMiUeqGGpw4rICXuqNxuEFhQTcZqSh9iQVMvXzW5j+478
	 +lnSqh2QxKVjg==
Date: Fri, 27 Feb 2026 12:07:30 +0000
To: Vladimir Oltean <vladimir.oltean@nxp.com>
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <px_b8_2gC-ZLFXok9C1Cjh3OAR-3fh7q3tMvB6ddv9V_IR2UOe0ANtPfCbh_s3xFARel2DT6Yg5cVJe3LPmgLpgDgGfqTrJuPa0OADyxdts=@1g4.org>
In-Reply-To: <20260227013151.qaw4hvb4fyt5roeq@skbuf>
References: <20260223150512.2251594-1-p@1g4.org> <20260223150512.2251594-2-p@1g4.org> <CAM0EoMmr0SUf7U3CTqd=MSYX=D60zYOfBS-L=GJOsWB-cxZHcg@mail.gmail.com> <20260227013151.qaw4hvb4fyt5roeq@skbuf>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 234b2a4dd7c0867d8a0afb78ee285997c20d982a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219948-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,1g4.org:mid,1g4.org:dkim]
X-Rspamd-Queue-Id: 18F1F1B6ED2
X-Rspamd-Action: no action

> The ocelot/felix driver doesn't offload standalone actions (TC_SETUP_ACT)=
 so it
> doesn't notice changes made to the action using the "tc action" command.
>=20
> If I make changes to the "tc gate" action parameters using "tc filter rep=
lace ...",
> then I trigger the "The stream is added on this port" extack error in the=
 offload
> driver, which seems to not have been written to handle parameter changes =
very well.

Thanks for testing. Just to confirm: unpatched kernel returns the same erro=
r?

Thanks
Paul




