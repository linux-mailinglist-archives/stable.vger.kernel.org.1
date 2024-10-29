Return-Path: <stable+bounces-89265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F39B55CD
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 23:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F03B22C15
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 22:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0784C2071F6;
	Tue, 29 Oct 2024 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jz0H6WGP"
X-Original-To: stable@vger.kernel.org
Received: from sonic304-22.consmr.mail.ne1.yahoo.com (sonic304-22.consmr.mail.ne1.yahoo.com [66.163.191.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBF2AE8B
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241017; cv=none; b=mwNABa4xbnwMhlFeUmSrvhn5glO4RsRLoOMbwnT6T3RA4T/NckkTocgMzrjXOYUCfVVyALl6ly4QfNT6wUz11soQdMsEan+sgyzvsOjYpsjO31lkJov0Lb84DYHt6C7QBo9JNY4MKf2F949ZOhD8w8BgFfu0MyLiB7qcuypQT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241017; c=relaxed/simple;
	bh=NaMgQ0LXPcwGogn576Yg4Pk4zXhhtK3GV9Wb7BnrJ34=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=pGoVHFOoqi+O9jTePB7C5Neyfzd0abFaQ0zD/57wVHXaritSdwyHwiJX8AdAsMAl5n/ct7BUn9bJl0LarlyyHrTfusiSqwPdER0/NU977K04fcNIG5sHu0KcaaojfZyOsOMoRGumXHmZQw/NceQqzTMNc7upem2yzd7V+ug6zKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jz0H6WGP; arc=none smtp.client-ip=66.163.191.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730241015; bh=NaMgQ0LXPcwGogn576Yg4Pk4zXhhtK3GV9Wb7BnrJ34=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=jz0H6WGPNnseEPXm/cyKdWYfzhT6IPRzMWOWpEyhKjzOIuLULBctN/8o//qi+f/les357NYMeDR2Ru22u4cMkZekygPoXh8q1k+0jxQULZFSvctONzoPw2UidfrlMsQVN0iiuaUjxWDQgiF+yfe5pQrJLrXesmAo0Khyl2YEbx5kOIs8CPw22MUsaluH/lPYnBPJ9R4NuJj3PABvObtNl/8qNrxmoOf/5xL1/ZgKM/RJN0+w1QYOer1N87AaZgtnVMJYcWd5ao2TTLq+EpfFXXyuQbxMsprp0C4TNzvvLqdLCCFlDamg+h0EabsfZbaVeauyVXG5NZrSyS/EXUPSrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730241015; bh=BuwmEDkcVgq0hqNacs7iQV8kX6PpEOIMMpsn7jqyGyP=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=d8DUR86XC3Wqm44Wq73cJKWFESsudt5KwTLKkubJklu5yWUorBdVTkhlkpxxwh0QtV12JnN2nVadJyJIwWD8H/0bRPPJMbGnxS8ND7lPID2ynop7x9ITOPIhe/MiUUQ0IYh1C8kC389cQ1lvd+WOkCh1A35WvnoqMmM5oFXI+dYJUtfYDInjE4Q/qOQSYHF3fBSF0+fmEr+wpJAsK2fYC/GOhB68VYwZKp+tCAbKiDRSjSQIj0BLspkFqbVRUv7FlWEPmY7MmTK/ZavcJIl8VI1uGc/Fc6K2YephUYRRk3ozoKZpje0baoRj6mWjwMD9s9BAMPdBbK4R7AnGwFDxkw==
X-YMail-OSG: HQKTGYgVM1mXpYWdd9p3nksf9HlG5on168ShRnRNhdXk93Z6MnsxXl6gFfCUBG9
 qQ8OgkNRhWXUN4dqfgnNdTZf4v8hI.8R6X6B3h_ll2cbz1wBAgVYzeZVz7rRD5uTei2FNid5u6FB
 d6RhB.IHYpSi74ycGov6CZQWSu6o36t_UP8RMs0IRCrElW.5EH6pH6Cxl6C8b47bQyZN2xqVkqWS
 fYp6M5jNIlQNTpOifqvCm6_rbM9h3Md2a1fLA1wejVOpLMmZaWrxeL7IkDK9kDLzuOcFKzdKj0S4
 IfqVw._vIcQM.7m1yF.Kr8IZTYQJhhrN9dE66_.zzqmUZIEs5o4Q3SkCbns4jQV.Quv.rbqfdBaS
 pJ4zqpuuM0pTwlXeBJS6AYcwadVJG7k717W0LMbCLNdLE9qCGRzmZiEBmEfOH8tyTO4FCl8hUDkO
 r1URHlZ6.Dwe7Tj40YUoErNjR9QtBtYKD_Q_6_PpaKtbq1hZkUS3F7IVf4HHMNa7p0FiNjux1hh7
 FIeNrcSnKMDAWUPgnQovEZ_gWpoTb.gGXzYsVErq0CM3_LUzSQsbT9P44zaQaQ5.j3iOQ1N1CmWc
 jVKxk3_ygqIU4D9v2Sr8F1a53uTJU4w1mzaTboipuEEMT6Yt.b5wsq_M9l07rjyWV0qUT8jUl5KQ
 ZqOyo3Zz0IoXISukSmJW60IjUSA9NvO7TW196SgEzVzqAdKFjDttUw4u9R2I58YQehzLrN27Pb1a
 Aps.j.AXkXi5swpeJGv.L6oniTRWK7rdsuLvpsy4io3hzhzBjhrjBqvpPW2vXq60jmu_vaplvMfG
 hCpJ9f2c6DOvgh.bjDL17S6Xg6.T5RlrTpjA3W84p3TCb5HOPJrqhhf_QlgeDB8MOxUnhu7G8Lkn
 StfX3gM6xDhwt8iGqpGgb3BKnGwe0Jyj_5kVG1Kv_b_QRpuccjvtIJzwSx01kgaRkdMFJ95omKwE
 cu04lVkRH66lep5ROrn9oxUYgYkaK2VAnwDaSmhjJOIR_I34J.GFJdL_GoEGdvzzQjE3qZD5aGhy
 Awd.2Nqfe1aqMd_hGe0BXR9hTZdj1KGrm3NObLBhCjTnw0Ae4Y2qcIUySdCjNMywHTMXMYD80MFh
 XKvz_WV2ZZSxrb1FQ97AuoLOIYN36u2ebECiLEYmFvnqQA.VcqJi5GSJsKpeCNemq14LLSxg98FY
 1936Hrt.VL6SxLUXPL6HycmoZd2ID77l8gQhZIERPRPkW8Br2TZ0l2PdfVDf72cDpWaR_egvbb_Y
 Dppf0OlbkpWyyJCdJjlWirvmGg_JeOcQ4QM2Bq2Dck0BTZ.9bTNgvFq1H9Y_Hv0Ks_6_Qwo9EMp3
 aARan1dv5LoyHHJ.87DjUU8t9Valt0chAjF2w1aCwF9JXcpu_5mEYhuOFAYYIAyg_.GlafUnhfFu
 tKedQ9B.eIM_KVfPs9TCIi1Y3SDASA.UixhZdGLtZ46R7AybUtSotMEuBvRwx384zOX1NqYCIkXm
 yBblxyhBgFWxK7MIDVOkK3kuC4ogvdbXrtyQJFtsh.ACJ_FFys0jyhgx9rw4GjnlkyWqByYseLjU
 Vx7Ogo9AfoSnlBZM16vX3V.oL20C89ipKMUpJJxeF2ykBx2Zc1Xtf5_0hrW13Ycju8vJJJFiitrU
 FfgQDnb7Fq5sN.6mV2UWzmhOrhAIVrcuZGUvMWsN29Rq_R80ZWMOkHjDTw3WLE55kDYT7x50bJfQ
 eRfCATpHkwXW6JfYktTSjYSSW132Jt_Pw26GbxBuZOHIiKs1HwRma7IdQD1T5GpDJhQcdMY3voqB
 RNW.XtGe8bJxHaYLXyoI2M_LndxPdD06q66JOdS2K5xb4EzV4GaCF9JLxo2nDeVlXMUMAyxk0qoT
 2gmmvhi.0rawAkp9Lh1HtTLHxOY_qdta3VwAbDlOm.uMd3GjO8O_pCVv1ln8WuRseBmunCsZlr6T
 xJYsJmeOqkPK8mKb0Wk8mBENlm..honU2cXBVTlaEfm0OghbDN7ooqv6CXruR2vGKYSYTveoyAWL
 7Cm183LWS5pUeugKxV8HkbnJS88OYkAl9HJg6HpYGH8ivxl7_HfC4p7uUClgtg7yDUVoUhypiR3x
 PS0qW7dVVyzw6tcbW.iCom0XMl5eR9r8PWZbK.r5Khi4FQYbD.LZEaC6W8FLIIpD.tm6KUCMP56o
 ntH_ZEOsFnD4cWEGQeWFcLKG_rj9.Ah5x.c94mI4A3IIpcG6sExsf8xrltgvw89Pm8PAeVEX6pf_
 coMAkTN1b6KLupHDq86K6TM40YmTugZln4iPt8w--
X-Sonic-MF: <adam.langowicz@yahoo.com>
X-Sonic-ID: 30eda295-23d8-4eca-80db-4e94acea71e3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Oct 2024 22:30:15 +0000
Date: Tue, 29 Oct 2024 21:59:53 +0000 (UTC)
From: adam langowicz <adam.langowicz@yahoo.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <651517574.7763593.1730239193485@mail.yahoo.com>
Subject: ZRAM - too much CPU usage with high number of user.
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <651517574.7763593.1730239193485.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.22806 YMailNovation

Hey. Need optimization ZRAM - on 1 or 2 user on machine ZRAM has low CPU us=
age - but on 175 or more user on shared machine has a HIGH CPU usage.=C2=A0
Can anyone test ZRAM on high number of user - and add some patch to low CPU=
 usage around of 10% to 15 % ?

