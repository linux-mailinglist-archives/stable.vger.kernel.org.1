Return-Path: <stable+bounces-238225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK1mJRAO4GmzcAAAu9opvQ
	(envelope-from <stable+bounces-238225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:15:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B54087F4
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFE2B30106A6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96532386564;
	Wed, 15 Apr 2026 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOucmPgH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A28723183C;
	Wed, 15 Apr 2026 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291297; cv=none; b=cdCnKgMDz+dTB4bXYDFidobchs7QBot8efCP6FHlaZnanaHCSDSWmbQ9pXXGYbV0K3JMgNvGpRdyUcY42hUCAZYVG9xbgS+YmMDB3igo0fZPWp0sze28Zw8OWA+3WvKHiJzbwlwVajbtWTmwKtFtaO54Z2Q7a6oEvYs4XU/3Fxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291297; c=relaxed/simple;
	bh=dx2/GieGQas5ZAKeKK6KdkErC4+FKtE6PISPEw+PXos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3yYZdAjFOvmYJnppxOXn6f5h1yu6YaMjlllR/FpiDLlc/BKB56tuACKqjqLAs9FAaSTdVCQ79Q/p1/WJN8i5R93SmD/hTbFXofOPABcryDTCgD0LlkROKyM3z/e4hldbZjJT0zeALkBo2ISLK9YtQRWvMem0JASAWxy2cpon8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOucmPgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAEAC19424;
	Wed, 15 Apr 2026 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776291297;
	bh=dx2/GieGQas5ZAKeKK6KdkErC4+FKtE6PISPEw+PXos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOucmPgHfgUrblt1bPIRS6oWss2sOJ4NWc5Vxpcu0s6lthbWz290pmsndn0G4RTAs
	 OdxSLVdzrMWchbGqbvB7Y51Z5LrE5F6tkfvaebzqpSHx9VHD+/owzxjFfCKmdnAgs+
	 H8Tzq8B3IxBORhqYP5cmCyaGFS3QmcLKr3+9cyQGMUJbHPT5D9PBgCdZ26XSoULSYm
	 Klaypqqhxckw1eo7Jn3wrqhIK7/0iG1wr+ERmfDftaA2/MgQwDtGiQbz2ZoODs0mri
	 4RSVhzKSIOyQKqsr7jLGB+KUOM9UBQXKS58byATbrOIEU36wqpHCHBM+KnXDTKhtu3
	 a+6sFuphHXKJQ==
From: Danilo Krummrich <dakr@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: dakr@kernel.org,
	lyude@redhat.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	bskeggs@nvidia.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: fix nvkm_device leak on aperture removal failure
Date: Thu, 16 Apr 2026 00:14:49 +0200
Message-ID: <20260415221449.2911692-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411062938.22925-1-devnexen@gmail.com>
References: <20260411062938.22925-1-devnexen@gmail.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238225-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,nvidia.com,lists.freedesktop.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D9B54087F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 11 Apr 2026 07:29:38 +0100, David Carlier wrote:
> [PATCH] drm/nouveau: fix nvkm_device leak on aperture removal failure

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/nouveau: fix nvkm_device leak on aperture removal failure
      commit: 6597ff1d8de3

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays.)

The patch is queued up for Linus's tree and should land in the next -rc release.

