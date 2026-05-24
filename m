Return-Path: <stable+bounces-254034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDDuDpkVE2q67QYAu9opvQ
	(envelope-from <stable+bounces-254034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:13:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D35C2CDC
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9A60300A13A
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB4390C81;
	Sun, 24 May 2026 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbYO79i1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFA368D51
	for <stable@vger.kernel.org>; Sun, 24 May 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779635603; cv=none; b=KjjmujCTXg6Aewif7XVLOjlpkBQpVqdtEs88DURhpZM1vbn48MwpUwfy3aJ7/NToUjdsTrRm7khdqw1U5JLvzJirMU/lEFBJ2m0+mbxaiyo2dwILixAOuCevIkQu4iaVjuh94E6IWWZQTawv+LGngrNe5KmTvLG5nzeQ9FW6CRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779635603; c=relaxed/simple;
	bh=Zu3gGtuTqnFdz9fcKA484V2odI9PHX+BsJ0FJk2RQHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB2cQrGgIVvndFOLbYfhm84pq/lTx2m4yMbkkaCIKh3PwKzvHRT6yj6yqME9wMKKAeM1L1IhMRbqAxxWbuA+BQu5b3xgxl1oe2ORf0qFSWI3P+WUJVxp020GvP8YdDGpJz8Q/VQL3hVwSxV3kI43kxZT1NuS9lGxcuc/OfnHaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbYO79i1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CFC1F00A3D
	for <stable@vger.kernel.org>; Sun, 24 May 2026 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779635601;
	bh=Zu3gGtuTqnFdz9fcKA484V2odI9PHX+BsJ0FJk2RQHw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bbYO79i1pXAX6xm4V0ANbKUudQ6aevSq6h6Ma8aK05eYtD3+UTB3WBW/Xz4fQdEii
	 TKFzXVTd87Nr1cm9UyVqhOg3t9Op+jOttuwiQFhQeTszymzs0c/vVZ4/iVoQlcWfXo
	 4i9RLKzvSSXygpgWlW40Aod4KgwNxMk6hIb5O6bk24QPIc+geO2NudFsCDpX6tVCBi
	 pouarFlNwujPIUQxXxuV+t4uTrBNo1AsvLwi7m+usJZIEyYYKkloDmZDRBw/RMs6/R
	 0JVQS96U1OdmGukrdL0sb+sF5WZ4YkKTS4zK8z8jKoai1TRciNikviYxaDREasTvab
	 VC75umq6idZbg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so6715809a12.1
        for <stable@vger.kernel.org>; Sun, 24 May 2026 08:13:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+9GIXGqSdw7Sq8qV62+J1AzH/NUYYxZ++wxryaOmRSUV6/iC2eXaHR7x5er09eFFrw1bNAaBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcxBwjQw2G/R6+Z1d5gTVhA4jU8Kv+GyVMMrTgrVJl+wfE6dY
	8oQQ6QCHPjzB1M4fadSQWMYSKdSN6i3FSwZqnyd7X1NIOy03H4dMmO1zPewibzlIUPHPBI9ENuJ
	WvLORX5q7FHj4IyB/3b3bBDNG4rkHJqY=
X-Received: by 2002:a17:907:74b:b0:bd3:48f4:4ecd with SMTP id
 a640c23a62f3a-bdd236fb2a1mr698008366b.18.1779635600615; Sun, 24 May 2026
 08:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_DE479764A6B5230E038C7F4315AD4C0DC606@qq.com>
In-Reply-To: <tencent_DE479764A6B5230E038C7F4315AD4C0DC606@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 25 May 2026 00:13:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_dXtirA0eFx68ir_-FzdgPGNcmRQOSvaZdZABkPhH1iw@mail.gmail.com>
X-Gm-Features: AVHnY4L1qq2oTu0l8hQELiK00xyLz9arJpQGdFT1rzzCTO7LleNVO3U79Pf3L1M
Message-ID: <CAKYAXd_dXtirA0eFx68ir_-FzdgPGNcmRQOSvaZdZABkPhH1iw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y 0/1] ksmbd: validate owner of durable handle on reconnect
To: Alva Lan <alvalan9@foxmail.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stfrench@microsoft.com, d.ornaghi97@gmail.com, 
	knavaneeth786@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254034-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A46D35C2CDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alva,

> An additional adaptation was needed for 6.6.y: in ksmbd_free_global_file_table(),
> the call to ksmbd_destroy_file_table(&global_ft) was replaced with
> idr_destroy/kfree, since the function changed to take a
> struct ksmbd_session *. This matches the approach in upstream commit
> d484d621d40f ("ksmbd: add durable scavenger timer").
I think we should backport the upstream commit d484d621d40f ("ksmbd:
add durable scavenger timer") first, along with any subsequent bug-fix
patches related to it.
Thanks!

