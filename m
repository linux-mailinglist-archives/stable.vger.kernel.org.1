Return-Path: <stable+bounces-254680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JOjFoRLF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 090A45E9BBB
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2BF5306A94C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78133B38B4;
	Wed, 27 May 2026 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNRyHXT1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88C3B19D4;
	Wed, 27 May 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911381; cv=none; b=TRdWILdJ94PzsBb9P905+wwLmFHJGK0tCbxNv5gf2uKpmd/Oz8np0K6NWqaizhij/4RcchKRJcbaOlKhIlqcjDBZw6S5k0Jv/GJhc3KyXL7wwmkCU3lDetSk0Awc2IuQBJCOmELe1ReN/sr0VXY2YKWzPjKXN4q5CDYQouX6ggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911381; c=relaxed/simple;
	bh=8tSxL6XHQweY0pe9aTEqGTJ903wD58a8gk7cW/dQ8pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrdiYZr33jMXOXsloRJMyQYLXlOoRemEwdUIjcEDGWL+g73pRuoZjfyT4csHhXOIzVgmJzN2oIPzr3vASosJ9LC0sK2tNmhARDaaJUWQGKZDEkNKFQs9/arZZ5sl8z1RqFUvWzJszg2DedFREpqiGNAka8daZtTnXww03ttxRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNRyHXT1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0170A1F00A3D;
	Wed, 27 May 2026 19:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911380;
	bh=RH+3FisZihLI78Vcaiatt7xW/7ToH+vAU53c73eVHcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PNRyHXT1j3ul9W/Rvz8Cr3GjHayP3KPKeatJzOjgi04b4YUPkAu36t+0fRU7leIE6
	 qf0GRbFz7IUDIg2fxzIrxb9vmMLzo8kMT2LfSY4EnfC3ufhx0iw/o7yuu+EYVFlh7V
	 MO/wDe5iix1VZt9mdoIHlGJx1DvW1bIla3mNRN4Vi0nssVu/eAN2MHFLxl/7oVGNZR
	 gZPpym8ryAtPVVi4UU/VsLpmaXXFFLJ9u7gtIlRfxLWlISCr/0/1pB3sVBAa58VQ/c
	 6JvmZ82ce6zm8YCK0N9n+ojkm+R1R0J0J0/JqKtBv+NIL3FH1DZL4dM2N5yc2a9Tbq
	 jXTxmnqv0pK5w==
From: Sasha Levin <sashal@kernel.org>
To: Alessio Belle <Alessio.Belle@imgtec.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	Matt Coster <Matt.Coster@imgtec.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	Frank Binns <Frank.Binns@imgtec.com>,
	Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] drm/imagination: Synchronize interrupts before suspending the GPU
Date: Wed, 27 May 2026 15:49:12 -0400
Message-ID: <20260527-agent5-item008-imagination@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <08d2dcf562adb5dcc2153dbbb97dbdf16dfdbc84.camel@imgtec.com>
References: <20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com> <20260524-stable-item014-reply@kernel.org> <08d2dcf562adb5dcc2153dbbb97dbdf16dfdbc84.camel@imgtec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254680-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,ffwll.ch,imgtec.com,lists.freedesktop.org,gmail.com,linux.intel.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 090A45E9BBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> >   - Signed-off-by: Matthew Brost (the upstream maintainer SoB that
> >     landed the patch upstream)
>
> For this last one, I assume you meant Matt Coster?

Yes, Matt Coster - sorry for the typo.

> > Could you send a v2 with the upstream trailers (Reviewed-by, Link,
> > SoB, both Fixes:) restored?
>
> Done now, with the assumption above.

Thanks, v2 is queued for 6.12.y.

--
Thanks,
Sasha

