Return-Path: <stable+bounces-197647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3FC945CE
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AF543472B3
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AA24169D;
	Sat, 29 Nov 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="og0l7J0O";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="IY23WwLj"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FA1E3DDB
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437717; cv=pass; b=MOMmv/8ksNrx94NcUlZhcG72313M4GYAX7J4HoYrEiGxx5hSadHFCfGlvWhGaNGqtAkdK1iVh5IrAIsTz+YxfvqY2X9d/iU7a+jIPMi2Ykr/dUl8+9o7xPx65fMj2y16rP6VfnzXMFFJkd/eH8P+SNc0ZOP2Es7AiGJFsAY2byM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437717; c=relaxed/simple;
	bh=nOhxluNrsjQLUXO/GeEyOle0vQo1Q7DG73F4mzemYyc=;
	h=From:Content-Type:Mime-Version:Date:Subject:Cc:To:Message-Id; b=AQ0NwJ2H0oIG+CGIO+lMIAHeAbXZb2liB68Basl6wURvC8mZWN6i9IbfbGh8pncg5FChQcSYSMTrs4h/tJyGEFrH4jFH9il21+C+QFnGoigykZQeU3hYKQ5b+fIkCG5uYwKBJhxYsZ3H3C67pKLC5fBtkMgrZzOFoPSRg6LdtB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=og0l7J0O; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=IY23WwLj; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1764437688; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mZCgjmRhnzyIXpNBCv6IJERX9+0LKNFhM9pmSu8YRdg0e1Ud9682jsXFwtokupCBK5
    x7+5OhJkxc0psZ6zWW8AC3uwvaSWr6CJonfjO/udCEkkvmFAUxf6oxtL8EtoDT7sUOKk
    y/pLr1UAtkJoAd+jVkhd6KduELmntkhMSa1mGGvDSn1TKaFufjtACSaQmyzL3jNpg7ej
    DzUN5MZSzMVt06C3ef3HiwB59vwt1DHcOfRwL5sPq521Yp0emdSyxyh/rZsAZLG0I43s
    f1J/PGE5J5SQLHok/1DhNqL+XU4JR1as/wK7X41vDsRspHlyy1/ZkEgyIZ7q9iJ/bJuv
    Mgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764437688;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=nOhxluNrsjQLUXO/GeEyOle0vQo1Q7DG73F4mzemYyc=;
    b=kh7qrtIsdlu9B2RiscDFQO+nxC7NmJaNbkJvNDOe8ZfH7BeO6ARXRRI7zeekwdUY2q
    WJTeJszVZpXvoe1sFTQwWNwN7dHnBLDYaywiCBH7U9gy8X1pxypwdgPMxT/g+hHvb7Rm
    xTZX6hHGVKlM+NVDHNciiO8gHvrQoLtFcca85uAXU34tAuiewklGsPD7f4GD5XWmJNCW
    ZKZXUdywWk4XHCs7UIwQpNSm/9oNxWDw5zwXMrSw/NLBsCyF4Z3p5Lg+FRPT5XiMMF5q
    CzeWBfSOIfwsZHneM+nJBSsxTJR3VhlkX2/xHKk74ZbpFvhKnte9GV8NyRM8q4Neds1C
    GGKA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764437688;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=nOhxluNrsjQLUXO/GeEyOle0vQo1Q7DG73F4mzemYyc=;
    b=og0l7J0OGpxMtD+rPk1DEsUFjAbADDmNyjA4n7pLyvGgjcdsQchRpabJOsqaKCR3oQ
    /txb2uGxCeVbjyeqeGjNOaHu0X5Sk9EKRTxAAZNG2ekIGEo6Y5TUjbDAkYhyTnP3wDhz
    zQWSd7jRAPq+BS9SjIn+Py8Wnb2kNdkuPmuU/tK4q8GlDs20QKTypZzYNZv5yU74ZoIc
    3U+pg0kjmIyFkoJPKS5h+IF5Q60fYdv/7rxqaXV63I3z4h1EwFxYJYOQdUjLlhVRakJS
    +qpAQuCDO6UpShgOgKETIvWihsupzx9BIbBoiA71vvBC9cJwjuO0rvCiz+lgGS042fS7
    eflw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764437688;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=nOhxluNrsjQLUXO/GeEyOle0vQo1Q7DG73F4mzemYyc=;
    b=IY23WwLjBbLD7vZpN1m3b5MB7ww/jUQQk6I9rbVjSqZpwKv593noRGeB+ui5dMW79O
    d5dq95oTvgKuGQTpa7Bg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeDgZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 54.0.0 DYNA|AUTH)
    with ESMTPSA id Qc14a81ATHYm46u
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 29 Nov 2025 18:34:48 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Date: Sat, 29 Nov 2025 18:34:37 +0100
Subject: please consider to backport "drm/i915/dp: Initialize the source OUI
 write timestamp always"
Cc: Imre Deak <imre.deak@intel.com>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
To: stable@vger.kernel.org
Message-Id: <23A212C2-BFAB-469C-AAED-375E979B9179@goldelico.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)

Adding this patch solves an observed 5 minutes wait delay issue with =
stable kernels (up to v6.12) on my AcePC T11 (with Atom Z8350 Cherry =
Trail).

Commit is 5861258c4e6a("drm/i915/dp: Initialize the source OUI write =
timestamp always") resp. https://patchwork.freedesktop.org/patch/621660/

It apparently appeared upstream with v6.13-rc1 but got not backported.=20=


BR and thanks,
Nikolaus


