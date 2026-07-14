Return-Path: <stable+bounces-274563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W76iNUSpVmp0/wAAu9opvQ
	(envelope-from <stable+bounces-274563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 23:25:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B74758F7D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 23:25:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="e600/Odh";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274563-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274563-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3B70307B5EF
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 21:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2391B429CD1;
	Tue, 14 Jul 2026 21:24:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05A429CF1;
	Tue, 14 Jul 2026 21:24:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064262; cv=none; b=A39y507o5Xp2La5FeeRrtEaNuGVAgzCUeNEEb+f+b2BtoWayEHvV+3Ch8ZPaS8LU930KAYN0348vdQenF3axWAcjClOQt9LyxCGYWIag0vo2pL+FUjQSJXKeDLF2dSRimCNDcQB9R1ceVd/3z+fbneiLxzbWWbHo5z/FdDI+mFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064262; c=relaxed/simple;
	bh=IRprx/zzLM/no5bP7A6ObVlOXgMiMLel+tX+I4fc2zQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nm7nRn/lOCwdP3PhQNDoojYTj5jOU/AeLLYGiOsxv5E9zqheVIEdgwn5JEJsT6LJ03eGIHTrgbNWvf+elJtIh+otfVBidb2Dm1CbY5vCLu+Ew/8//71ZYxepwUlGMh8uj5h6dzZkc1uTZpgrZEHRDrGvCMotK+YcyVJRBJVuUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e600/Odh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14E01F000E9;
	Tue, 14 Jul 2026 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064261;
	bh=Mdxkfcw31jNebgrllO6zd2ynWr48DmtMYl0qIDCd0Hk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=e600/Odhq63GMHvFjmw0+5G4BhJlWd6PeGkcSEoRf9ArHi5HvBqZeizypQH2hHuIF
	 NeaBsAaOjDageEnHfGnyy2/oeZaeYlzASZVir9tn4kbnXq3Z3unka0BwuyvUISFf+h
	 86tioRwUYrmzo/EDWQLigdsT0CFwZXXCx0B4Yoe7I22p8LBLc+MDb/WHZKjyHfE/9v
	 1vFXfwEUjs85y1qDiIpjwE/HNYqCCw+qF+yvzYl0FuJ9q932RhdjzX7GWAfEK0nC+a
	 iB5yDP5JaYGFMwh57xEP+uHYQp9fcAqi5P0+PJU3mSa5byjoZ0G9BdzOMkdbzN/dzL
	 nVW8uvAxrZaqA==
From: Mark Brown <broonie@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Weidong Wang <wangweidong.a@awinic.com>, 
 Val Packett <val@packett.cool>, Luca Weiss <luca.weiss@fairphone.com>, 
 stable@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260704192857.88366-1-jorijnvdgraaf@catcrafts.net>
References: <20260704192857.88366-1-jorijnvdgraaf@catcrafts.net>
Subject: Re: [PATCH] ASoC: codecs: aw88261: only check PLL and clock state
 at power-up
Message-Id: <178402818271.7661.46768093185969066.b4-ty@b4>
Date: Tue, 14 Jul 2026 12:23:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IRprx/zzLM/no5bP7A6ObVlOXgMiMLel+tX+I4fc2zQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqVqkCOsIOa5N8rD9k9NiVyBNvXbsYJRdRYJqzv
 z1SfSWy76mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalapAgAKCRAk1otyXVSH
 0IH7B/96DvSreSns/50bFZovlLSJe0kBuQCnw+AJcP7sb2+CTY/HpB2fWSWhmNO0j9zQmdWunK7
 Cav+wGGxm4zpTrd9GJlJghRp+RBCD5HYsXqvdKhB5SbwEXvwwf6LYEmmVQk3bL9eUdiTOC+FUYl
 Rh5R7BCny2muiROJnr4aRYWLFBdJFotaALi3h/5WXjaF3NBdVyDVhOZWDv1ODX9/QNkjzqayeZ7
 WdkZnUlOSsMYsDZoN0Jof2D7KwVnrfEvThklagHDC7Y5hqWFA5dPf63Lre15K0kXYswDdvY62jS
 CrzP3br17VnMYzYeELSdAuIM7em9bXSfDlK2dV/F9MHUHJIB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274563-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jorijnvdgraaf@catcrafts.net,m:lgirdwood@gmail.com,m:perex@perex.cz,m:tiwai@suse.com,m:wangweidong.a@awinic.com,m:val@packett.cool,m:luca.weiss@fairphone.com,m:stable@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,awinic.com,packett.cool,fairphone.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47B74758F7D

On Sat, 04 Jul 2026 21:28:57 +0200, Jorijn van der Graaf wrote:
> ASoC: codecs: aw88261: only check PLL and clock state at power-up

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: codecs: aw88261: only check PLL and clock state at power-up
      https://git.kernel.org/broonie/sound/c/06b6f1245567

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


