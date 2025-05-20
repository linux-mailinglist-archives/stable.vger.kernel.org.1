Return-Path: <stable+bounces-145052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF9ABD51A
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 12:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998061B61F9D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FDA26F448;
	Tue, 20 May 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yTtJJTf+"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B926A1CC
	for <stable@vger.kernel.org>; Tue, 20 May 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737296; cv=none; b=Js/n2/7dzFWyt+KeGG1QcTxEslJWbfeS2zPV2XBkzEJVMoeqAlQjkkbASsomEw7ndGurYwMiUDIKb2k4pSlAWDKXsRCu6Rl5AsIidaRPOZoPvKuF4d+NxQohbU6jIa1S5iTWuJILa5YLE/i0QXgBc7xSaV8nAKktm5WLm1Fi2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737296; c=relaxed/simple;
	bh=sNowNwaOmVQrv9n6Qm41YjKIHjHyCQov3Jn/aKsP1Qs=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=TD9m0GzVOFNL4OAhkqwuQf+R7cH4yyCY6sXsmrbXuOZ1pFju+uwnXdZZwPW3M4nJ/7sV4Hbk/Jyg34tdTR/Z2fJorTOuBWC/kBEWzSVpFDJwFmzxWfzSmYq/AcFjVjZvhZDwKu2Mdp1gDKlju/ZJVFlbYZWrikouelLcqB5NX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yTtJJTf+; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b1rXM6XY9z9sqG;
	Tue, 20 May 2025 12:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747737283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=BVMlaP8+u6l4nsk7wf3g58KFn3mX6Wxwx6veak+dFd4=;
	b=yTtJJTf+arkoW5RF5GmJdzcb2Rc35yH0MtDNxVXtDk6eDPeUfuhDflZLrvFQWkuvxiOIXC
	Gb+CRjYbRxZwErrWm1e2pJLC6VbOQcctVz4EbfC8b4zX4CT0FhpFSdLyk5uw17SKYViKz3
	N4KAhk+7k71vGvT4OAJ0v7J8KJdjSCTKje9o0v032Ibtu9bc7qNDNdDa3ixYSty1/zyVQz
	CM+M8eK9Rt0w0hiCv8oKLqEURIjR3LnihhQMAk0Ld5CeNgtBF6ANhUGxQAi4bm5lUDv/nc
	D1qKE5YFZpD57+iEfmeN37DQfgS6WAzUp+sj6244gGYZ4Eh9Kc2PvDVDzNeHHw==
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Wayne.Lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>
From: Rainer Fiebig <jrf@mailbox.org>
Subject: 6.12.29: amdgpu-related "fail"-messages during boot; bisected
Autocrypt: addr=jrf@mailbox.org; prefer-encrypt=mutual; keydata=
 mQINBFohwNMBEADSyoSeizfx3D4yl2vTXfNamkLDCuXDN+7P5/UbB+Kj/d4RTbA/w0fqu3S3
 Kdc/mff99ypi59ryf8VAwd3XM19beUrDZVTU1/3VHn/gVYaI0/k7cnPpEaOgYseemBX5P2OV
 ZE/MjfQrdxs80ThMqFs2dV1eHnDyNiI3FRV8zZ5xPeOkwvXakAOcWQA7Jkxmdc3Zmc1s1q8p
 ZWz77UQ5RRMUFw7Z9l0W1UPhOwr/sBPMuKQvGdW+eui3xOpMKDYYgs7uN4Ftg4vsiMEo03i5
 qrK0mfueA73NADuVIf9cB2STDywF/tF1I27r+fWns1x9j/hKEPOAf4ACrNUdwQ9qzu7Nj9rz
 2WU8sjneqiiED2nKdzV0gDnFkvXY9HCFZR2YUC2BZNvLiUJ1PROFDdNxmdbLZAKok17mPyOR
 MU0VQ61+PNjS8nsnAml8jnpzpcvLcQxR7ejRAV6w+Dc7JwnuQOiPS6M7x5FTk3QTPL+rvLFJ
 09Nb3ooeIQ/OUQoeM7pW8ll8Tmu2qSAJJ+3O002ADRVU1Nrc9tM5Ry9ht5zjmsSnFcSe2GoJ
 Knu1hyXHDAvcq/IffOwzdeVstdhotBpf058jlhFlfnaqXcOaaHZrlHtrKOfQQZrxXMfcrvyv
 iE2yhO8lUpoDOVuC1EhSidLd/IkCyfPjfIEBjQsQts7lepDgpQARAQABtB9SYWluZXIgRmll
 YmlnIDxqcmZAbWFpbGJveC5vcmc+iQJWBBMBCABAAhsjBwsJCAcDAgEGFQgCCQoLBBYCAwEC
 HgECF4AWIQTrLHk+ME24YHaolcbw4fcmJYr49QUCYVlg+QUJGnvH3QAKCRDw4fcmJYr49Wta
 EADHXEnPxIsw5dM0Brphds0y12D0YGc2fBuTeyEDltuJIJNNLkzRw3wTOJ/muUHePlyWQigf
 cTieAP4UZmZkR+HtZdbasop+cIqjNrjeU1i+aiNaDf/j6JMKaXVtaXfTbwA0DFJ2olS7Ito/
 v7WPf5zJa7BnWFa5VbMQw2T68gOGpMuQky9se58ylQcpjBD2QVJiL5w36JTZpG84GfvQnFdl
 Fu9dh6/bYDUiTVYWbWCYNoDiEam3GEgsPxWMyb2R9nkBDEUKp9jDxu/iJl5nbX2+hoLDcD7v
 zM+sEeXLgwn5OyRxKiFYLAaNPUow+J8JG7NUWHVvuHtiu4ykNfoIghyxPENs5N/nndJt5KDq
 kWHlXhJOyC6eDCt/47Ylykau/bDlfrmgfoEoLt8X59sZaQAgkV0yjrPl4bEW61eGvcjracj5
 lsDP15MITm+OND3LLSg9Jxz8LOYs6enLxy7OmFIJF685XDhtDdvGSVCbdB4Ndhygw8HiDxnZ
 hh4ByX+N/v60g3IdoFXc7v8GIDMTtSukOwKlm44jENcFZBjjC518OH1ugLcbnR/f+vT9L7tO
 fDNahD1nrLNsOtZKkW1Ieztl7EEz8IUZzjMqXuEWSEZn0luE8j6FnuTr1JId8WL9AqM/vcVY
 /UN8v4d4bUvjQ2+k0U3aMsumw+Y5PUsiFfy+gLkCDQRaIcDTARAAwhbtQAUmZG/rkpR/6/xr
 7jRqi5Z3M5LZNw4lW9k4nBpQDAP/rLVuREnz/upm314P9i5iN9g2wsbReZBJ9KiUxT39KD5p
 99KZGIH0elgZy+nDnb3oQLbtAr8+ox1ThOyOEJ7iX378txc1JD9IWJuv6YLMlkXa4ZuuAMCq
 KUvCChEjcHhZ+Ecb8OX8GwIKUoklWhoHR7OcMqAkjdhA698FkWNkgIeqMiTN/hBJ9u010ZeB
 82ibDAKSMetMRxflCwThrVrfrOr5+ZkJvoN5r+Jy1ulk8OOnDOjvqXoUcee5zdloZymeY3f7
 zebddvPmuiR0qXX0KYeSbhNF1GugLgbYeU2ev0nZ74F6vTwLUraRjKUzk0bq6SELlNMriS2x
 Wj7zDB2XtzUdTHPYSgFDKGYxRqiM7KJbheCL7gD1wxUGRf14yJISXmDX/fZhsFrZ/NF3UqxJ
 nLCz9lqyMCvT8prJjlAQu0zcFcrGAYVBNeJMAKlukMllRMgWdSLmJQiDC5JMaXoEeXdGpIv8
 LgH+yU3tkKjXvkjwGywcXuL28ZScap3iJj08B8HWHmlL5b3pCkZv1w87SSF+FarrWl4F4u4U
 j+u2r7/NEZVmJ0GpNHNwkYFQiX1Coky6+Ga1/gXUBP6grI9eZOMD+qtsJC1JVPY8VIsjq/47
 R1tBTKoiANQ/M+MAEQEAAYkCPAQYAQgAJgIbDBYhBOsseT4wTbhgdqiVxvDh9yYlivj1BQJh
 WuePBQkae8fdAAoJEPDh9yYlivj1GmsP/AwKF5WPyg3M1e7YPAYc3vsp2RQccnIjQ62MYxbz
 VWFs32GT0FyeIBzzT5aaVNyWzumNSyp51LC29AeqL/LXel9bUCzg3v0g5UutXAh9XYnWvgD6
 12U4WlFUPmSVKz7B1kf9fwFfOUyRnT1Ayf91GDW9vTP2yWboXqelQdawa1Wl7G+C+unyuu3q
 OoPkNu65g6ZanO66ycXz6BDOlfCP7WPhcdyi85PuaJhXGbOysKS/m+tptS7XStqp+9Hvj1pj
 3pajr5Nktufg3+QLQTj7iUowMnHdClY5d5c34gayzXHIZw9pSM4u4NStEGUTHk9JVRNd09A0
 J3PzCngz9isv6Cdi7dZH4ivjOqXnD3Wq6Dwmu2RaBciQx8fuM58o6VBQ2cQa00QRT96UPWph
 G5BEGryzI0IxAmQtNDwneJx+jscGmMWvm4PkTViBnRcJtlJVO0lR5tWjscVG4TgBIo1M5qmi
 t0GfVUkS4E8AhVNtPG1Z5vl7JkfX3irc4ld58j1STfhLuos5l4X+7lRncpbYCsuk9rz1Bjh8
 r/bUbqMkpj7m27JXi7cHIOtZ4up9O0O8WFdPpLRmy6GS67czo5dpV3CowY9LtZ0+0JmnUd59
 kutl2mu4Qd3cGFbZB4J8J3p+wtsx7bujP38lQvmqpyGTUtyoGO9nOL0X5Xi95CAqapnE
Message-ID: <e5faa1de-6a41-5259-6f69-66ff875ed9bf@mailbox.org>
Date: Tue, 20 May 2025 12:34:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2e5896f51c618cf109a
X-MBO-RS-META: xgz6rg7w7cjatexmpgyrf799yo8cwom9

Hi! After updating to linux-6.12.29, I see lots of "fail"-messages
during boot:

May 19 23:39:09 LUX kernel: [    4.819552] amdgpu 0000:30:00.0: amdgpu:
[drm] amdgpu: DP AUX transfer fail:4

Bisecting for  drivers/gpu/drm/amd  had this result:

> git bisect bad
2d63e66f7ba7b88b87e72155a33b970c81cf4664 is the first bad commit
commit 2d63e66f7ba7b88b87e72155a33b970c81cf4664 (HEAD)
Author: Wayne Lin <Wayne.Lin@amd.com>
Date:   Sun Apr 20 19:22:14 2025 +0800

    drm/amd/display: Fix wrong handling for AUX_DEFER case

    commit 65924ec69b29296845c7f628112353438e63ea56 upstream.


The system (Ryzen 3 5600G, latest BIOS) is stable so far but the
error-messages are not nice to see.  Thanks.

Rainer Fiebig

-- 
The truth always turns out to be simpler than you thought.
Richard Feynman

