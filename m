Return-Path: <stable+bounces-235645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD58KKsl2WmnmggAu9opvQ
	(envelope-from <stable+bounces-235645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:30:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533973DA690
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50CE93030B32
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F042E3DC4A7;
	Fri, 10 Apr 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJJEeq5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4623EA92;
	Fri, 10 Apr 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838559; cv=none; b=uks/0qovNw8lKfdcMY2LWdnWCz91GhaNYwgkiQx5SSg3WnFd8w0Xoj6sQaTSA7fq4Hd0UEpZNz9QX4KsnEGuQc2QwNQpRCu9Iuj4O2to0KjJiqO+4ngFOLbnknwltr422OGf4NLTUqs1BOI9nTSkMUXNhs3Ms9LXbjzJZQsljeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838559; c=relaxed/simple;
	bh=0jX07eM4mmibrnEfvCWCE3d/+3WE1nga3Kn4QNloSSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VCI17Q8q/a2c1GivFpQhsTrygxysdPfpNt8C/IuXG8lvZ9J+4seAaBbihRoGJo+Do0opp146gyaUG6nNoUNlEYptkKOA7HW4JBxa/+Qy+TDNYBHuQUzEmA78sVa6KNKEHzMPOBFnJ5mmHLFbEIp0IbiJc809s9ZFI1f2RZTBa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJJEeq5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BB2C2BCB0;
	Fri, 10 Apr 2026 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838559;
	bh=0jX07eM4mmibrnEfvCWCE3d/+3WE1nga3Kn4QNloSSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XJJEeq5db2962txljYRyq9ztOhriACBoRIadrK8PGQWQlfeVE4oHrfoPI68+9gnOI
	 e7QtOXRudqaSRE8sB8GH41La/ctBY8l1EiX2kwpDpxEUtjmOhFka7feNrFMLoMisbz
	 lo6cDz7bwByEroiASkyzm/gB0fIZtcWmt2y/PZyMkWfwKOWhTe4fczK8amKuT2lojq
	 OQDR+nGyMwMHwhbNkOcnwIy/kgmDKxXRjf1tYgOSzw/ylIEbH8QE8nc1MsrimBbps7
	 UOfvHVlverYDrsEfUhZIZetpnxNugr++MmCw5okCS2txjUJz7LOdFse5v1aMR1esGb
	 6JWjvfpVeB/OQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260410064749.496888-1-johan@kernel.org>
References: <20260410064749.496888-1-johan@kernel.org>
Subject: Re: [PATCH v2] spi: fsl: fix controller deregistration
Message-Id: <177582354107.1175120.16428988972509769575.b4-ty@b4>
Date: Fri, 10 Apr 2026 13:19:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0jX07eM4mmibrnEfvCWCE3d/+3WE1nga3Kn4QNloSSM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2SVduKcNHNLL/2XZWjbeBIOb/OpXy/jTcO+O5
 I0rGLJBPjyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadklXQAKCRAk1otyXVSH
 0L2uB/9qo8Rek5RnH8kvNw5SNalxsGXOCmVYgqqiczJLFZGO6E5k0FyCOBJ74P3u+InLNqCanVt
 DdHYOiKVUEXa9gehLQy2vo5RJNIfb47bezimuiR9fi7Kq093GHDZIavE2UyKvCWcJjG1olmZi5w
 iWsH11dAkrE/xjrN72AKLdfUhWZujcaAmSppILE61r6kZTjkfufdKvQvQCiFm/CxebkgdJ5bM9a
 KcCffUv/lmDHt9mrBC13JFsMONL+gkTaI+6l+U4bYhHMufc+b38v4bsfG+s8rgsDK0wYeeZc/HD
 e8MZIJV9Xn1gUiMvbWAjRauSzluipkMi44KyoCBN8HSrL4sw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235645-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 533973DA690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 08:47:49 +0200, Johan Hovold wrote:
> spi: fsl: fix controller deregistration

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: fsl: fix controller deregistration
      https://git.kernel.org/broonie/spi/c/9b7abfed4c37

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


