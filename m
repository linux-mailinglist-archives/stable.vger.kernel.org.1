Return-Path: <stable+bounces-230495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NeCKp1gxWlM9wQAu9opvQ
	(envelope-from <stable+bounces-230495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:36:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BA43387F4
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03AD83012839
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB03401A38;
	Thu, 26 Mar 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHm+uqrG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E073F7864;
	Thu, 26 Mar 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542086; cv=none; b=dYW/W43hwPd1PsVHcjrr/xBixDkU+AYAbUaclp0Y+gyR2ERPG+ojMIDGn2sDZgWKdsE1D6cfFBLTwmzh1vpNMPFjtOmkcItlSmDRplq1Wx7SoJQ/eYtJrb7771DDrIWSS6JWeXfClPEesZZU+vBVPgfRxoxprb1sLPCPAQVAKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542086; c=relaxed/simple;
	bh=5Ky7siOIsPucYIVHIfrNrhQ7h5qedFWDCm+Rygw3nB8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FYSvswkx1+v3L19WbTEsUnUewxHG6Q0VkArHu7zx10tgfOgt5Z/Xsh7WVvc+Q26A10N1I1trR7U5m/WLp71xNIhPCoSS0ZFBZ7gEjlaSRUTftxj0r1Npi6EApScShu5/v9+e6SbMEDxdJQ2/bKb2Kp+5iSqIM1iBD22sVo/9N+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHm+uqrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89334C19423;
	Thu, 26 Mar 2026 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774542086;
	bh=5Ky7siOIsPucYIVHIfrNrhQ7h5qedFWDCm+Rygw3nB8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rHm+uqrGCg3xr6POSm1wJ/4ax3xLJL4VVTsViSA1kbUR/kdKV7GV6VQtU1+BnJOtM
	 yHC9TyviMaGQrncS3N3SyvOBs40w8bkADfLFpcVEvvZEbEINPT7x7zgpWg+IpGI6aF
	 hiqW+D7UGa+s6HbHyxTOdvRJxJr6Sbgzzur6pslXXB/DEpjc/y22iSN02tG1G54AMN
	 W4qvoyPdbKRMTcsmfPru59CgUuUM7OzPhf1oa7Mos4kCRZGdgFdq9ovPBtsXUcK+bT
	 vWIMkOkHgw5IkFkdeA/dYp1jaKPrGfVPEFn1sAmRPbJ4wpFw9/OoSXgJb8uIj64rNW
	 Wx+wmQnxphTlg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, seppo.ingalsuo@linux.intel.com, 
 liam.r.girdwood@intel.com, stable@vger.kernel.org
In-Reply-To: <20260326075618.1603-1-peter.ujfalusi@linux.intel.com>
References: <20260326075618.1603-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH for 7.0] ASoC: SOF: ipc4-topology: Allow bytes controls
 without initial payload
Message-Id: <177452378239.64163.6551845130950255246.b4-ty@b4>
Date: Thu, 26 Mar 2026 11:16:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5Ky7siOIsPucYIVHIfrNrhQ7h5qedFWDCm+Rygw3nB8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpxV0DvZ5K7WZowAEsmJ2RX3FH7J1sAryB3bVE6
 dQRni9tpmCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacVdAwAKCRAk1otyXVSH
 0L8fB/9DOwnMyP61BBVn4QW5DD6qk6OPhp+5MXR35b/yorbnlt8P6Kkkntaia+jUPhKl6dpmyDy
 2eC4Vs9pfyeDkAj6RbsFhndKupgE9PRPHeJbWU4K4erq3LrAG0vsWsBYNrecIKYHiVMS3s6IUQb
 KGY03eZrHqL+8buM+iCPi6yboYdC7Mg/SQcVn8KCjMPbk7diZsm9XzGuplG2ueF/tDpRhDeS2vl
 mcdOeR7A2nRMuNTdlaroiQzzZg8TL9DkmVIXpNlda8ryWp58i4CxetaNyiix7V/SBhiL9fgtnZy
 NcB6cWJ3uTktmq3Rt/dyjdM9EmWHDPebK8SlnzIZmdgguiGX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-230495-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3BA43387F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 09:56:18 +0200, Peter Ujfalusi wrote:
> ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.0

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload
      https://git.kernel.org/broonie/sound/c/d40a198e2b78

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


