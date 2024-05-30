Return-Path: <stable+bounces-47729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA708D4FCC
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660CF1C24671
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F6221350;
	Thu, 30 May 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJO7rjSV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664618755F
	for <stable@vger.kernel.org>; Thu, 30 May 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086327; cv=none; b=q+w/EinxWFjNbumcTQbV/AiCrzVUdQKT5XHZUwda+mL4nYNltztPzcJBV0OJteaRJWCVzaavoBQvH2gx4dIEhlgWodpz/bcPeN+3/6ry7YyeBoGblecxL0mkBIAKnI4jo9eDDwcBANw/zGarXtdy1lYcSlMdEbHg0ifP6XasSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086327; c=relaxed/simple;
	bh=xtA89f9CD+ERg2VUxhlCMTTNXJv8Aaj6PPDYFxCAGCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bxnIKItnN4IflMP3z9w86rg5a0vm90uDw12QXbVXBXKKZ7ruHWd5oc15ezQGIGxjZ80z2jumNEqAZ9/2uX7UzaBLGIPtl3czYM6x9Mx+Kph+JslWdGuESQdu4CPZ5TZS2Cfarb95BthzcmHLAXdCaDzyqtys1fD7BOGDANFpEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJO7rjSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B276AC2BBFC;
	Thu, 30 May 2024 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717086327;
	bh=xtA89f9CD+ERg2VUxhlCMTTNXJv8Aaj6PPDYFxCAGCI=;
	h=Date:From:To:Cc:Subject:From;
	b=kJO7rjSVTIbQ+9UWAPHlg9OIxPsDkXCRcTTs4XMblgXYxiuJeQFFPVtl1OOZo+P61
	 fSykwFr7r1eaCqz3rA7lBNSZ3NEPB7WYCZ2a99MyhcX0eTUrwddlcZbPOYS1iTdrfl
	 h8HLG+DUtxUH03OG84qc87D7hcH/648KGCYV7f+E2jYgWh5ONjSmwfcdmBU99cJDm9
	 xdlAWiPGbBPrL36u+kqodK0LWx+md2sDUqO422pq6oc8LdIy8zPNBgT6DVyTkglT1C
	 6z30J0Bz7ZorEkKiFamOc/7mPrA1Z8UOe64xLRWgK5R3Ycb57Wl5VdvmV3benvHbR3
	 O6jSfCj6bmwNw==
Date: Thu, 30 May 2024 17:25:24 +0100
From: Conor Dooley <conor@kernel.org>
To: stable@vger.kernel.org
Cc: shuhang.tan@microchip.com
Subject: Backport request for ce4f78f1b53d ("riscv: signal: handle syscall
 restart before get_signal")
Message-ID: <20240530-disparity-deafening-dcbb9e2f1647@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IeMFdEAVgeGnDHWA"
Content-Disposition: inline


--IeMFdEAVgeGnDHWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hey Greg,

Could you please backport commit ce4f78f1b53d3327fbd32764aa333bf05fb68818
"riscv: signal: handle syscall restart before get_signal" to at least
6.6? Apparently it fixes CRIU and ptrace, but was unfortunately not
given a fixes tag so I do not know how far back it is actually required.
It cherry-picks to 6.1 and builds there, but I have not tested it.

Thanks,
Conor.


--IeMFdEAVgeGnDHWA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZliodAAKCRB4tDGHoIJi
0qoIAQCfuRC/2vrTw0k+kOmO/zTmEa9DMBlELTPoHJFaeaM04AEAjLA2F+XWth53
KLZw1tCzGL/LjBWh0k0LrgO300qlEAc=
=fKkd
-----END PGP SIGNATURE-----

--IeMFdEAVgeGnDHWA--

