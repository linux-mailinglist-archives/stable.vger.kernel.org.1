Return-Path: <stable+bounces-204189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75110CE8EAF
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 08:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03AD9300EE6A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B126FA77;
	Tue, 30 Dec 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dNvwG/Av"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC01BF33;
	Tue, 30 Dec 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767080812; cv=none; b=SLBI8O9DcASFPSUR66qSLnndWNpy6Y/S2iVizjF3CfNB0YtiS9fM560zEj477XPVePFyZP2RRk2Ui1moL4AKOCupaeM/J5xisq5P6Yq02uz0RjmnKru40IQxyeVY6kKDdHAHHRPR+axswqTY4Q4UAXyMrd1IFvFkk2KpiGIJ9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767080812; c=relaxed/simple;
	bh=7jgWzOSd3c4/TI4eBNqPIV5ouPpTtq2Iny8ML4C/TR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD9TvaxwaKFzG49VYh2Bh2xxibxG1DcBrYoT8RQ8U3ctKbIYTjFGd3/lL27y3IjBFMzlIdH7daTMVnSEwhvmfxiSJxeI9WMxwKQ4aRJo1l68CnkU+57I9VHDSGb8QWdaNEflvyfjLqRtMNHkzHn4k5Uu5gFzJDUYJcEjrbI7hTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dNvwG/Av; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767080797; x=1767685597; i=markus.elfring@web.de;
	bh=7jgWzOSd3c4/TI4eBNqPIV5ouPpTtq2Iny8ML4C/TR4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dNvwG/Av/PSxsIAnMeZgLugq+dDR5yEbDmzm5qsWzYhlEQ9QAsad7BlabWPHUjQl
	 SuQyD74SpSlt5EvazpQLSnwNzHB5636d7pjcCAXzlexemHohyu1WL15wvLyRiErom
	 ydcmHTT0dsg4hhwg9v6IYh3HHfdUGX/ABbBNWt7JT58AKcoNFut4iejMvCQFlARsA
	 Z2QdXel0pLWmMSx7EQka+r7grQtrkvZ+QwI2Y6VhVSnIi1Ytc0df7JkyNp0TZQRJD
	 Sb9lF4MaFdp5U4/BBNU23FAXxt80JamNNcl4oGJ52vnumpxpGUE/Ls8TMfqg54D9f
	 XG6GhXXZSprHFt5+Ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.0]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1vFPB21CLN-00VPZQ; Tue, 30
 Dec 2025 08:46:37 +0100
Message-ID: <57c723e9-d38a-47fe-9737-5b472916f3d2@web.de>
Date: Tue, 30 Dec 2025 08:46:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] gfs2: Fix use-after-free in gfs2_fill_super()
To: Ryota Sakamoto <sakamo.ryota@gmail.com>,
 =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <agruenba@redhat.com>,
 gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
 syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zSzoFl0GZQnkgKMC6J+rRP2ltFJs7Q4YOT+5mtuPFgMAK1Pklrq
 hA2lfnCQ0CW0OF7Z3wYbFNwmxCGyWFtHBU2IXjfNtd5PrjCq3bL5Z0jTOOFhYfZysojTbTw
 Hnr5C4ZkGfoLVS7KVOtUrnONmiYFWx1wQfBCVLxC/zf5NYeiUf5a8k46vudKMMhroQRaHQ9
 i9NnswrwteFi/fjSG8Frg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1rgeMLltv/Y=;Z+zASM1FDxPLWFjvhp0C2N/bWzH
 HFRSTzVfoPXgWVPvopdjxgRFSiYObBuhtNSfGkM4uhhorQFFB2h98O+cQnJMHLf83dY2v93fL
 bBNNliyzKjIrbF53j5l+er8QC7j/3ND+N3HfnHKcmmkstFsYmacOidO8mfG0RHsUhwsUU0gKb
 rt3rL1LxiqO7zcwCk5Fp+GCYejCqs6t/OG011gl3rinmHejKSXDr++pHuOroxyglqFg9jqC8p
 jaScBj06aSN5x6cTz0fa48/pIUxll6WNyggz0Vv/WiWgkuadSDoCSrRb3/6GGg0jza0fp5v2F
 nql6CG26TKPaLPSQ51p+li49uACOg49Ctebt+v+pC8fYDtQ1nPiD3IC8ogWLi1IOOgGAng5Fs
 RLmomrxO7PamRUv4lduoKXoMafP56lTMYjvVqsQmVkF2UHImvzSTglD+V7iZH3zTyQTw89GqH
 p5lrGkBldq8PrP/IR4ec49iePJ6CH2z8UiLR9YZx1f8peUyktywlCkj8pfXRqqTfnNSaFqMdZ
 tcwKliHTrxN5hzxhhnMgFjACHeoN5BBH9LpmCH83Qda6N0Ua5McSbhS9AhdGgcRoU8cjzw1oB
 5iKKMGbR/iBugpPVn+SJR6jnsvYvcY+8dNTqXtK3ZC7BXdECLqON9bphzVEG4mzEgM36FRqdl
 07PcVnH7QqSieHipQEH+fqpZyDxUINVWM47dtKE21nFY7AjEF4YtT6yxab6e6Crvvo4pxW3wR
 odoHjdG0BCwVA/IUwj4fTW4rnpcP83BJDgTz7yVEBYdD641wUg8QIfApGCjZAfXXmcA9t9ezn
 Va2N/B3R+CQ2+Ul7XoMImuiyHsZTrflob2Xw/wIehK9MNlZBiFu7+ztD1JuwPxOF5x3y8k/7G
 LXRpwgBo86gXM32Jr5AiUIml3ran/zZirkqJHLPVa/yHKERUU9l0bdJNVpW+eSUzvfy9PqBf8
 5FDm2xq9pYO2p7BEbU5vAze7CPI9qYiadkB6uDjOXLERte4WQv8LWWH8kzjs36bBwyWDuvI5z
 9IOJh/cWgbuTQagNV+n6TsEZ9oxZsynRZx6xPilCczvtz9NEQtwHGJcROfs7BBMBlOIuPAhMM
 18svyRx2qNIMiXf3VRe7rMMXJdTzsAfgrS/02+vn9EXZGSBsf6Eqq6plh5C93XDc5nTKt14G1
 HphexefuNL50FcevI8iFCP4Im7fnELGCJO1ntRbJsL5Qm2WhhwS+OE/Hzfd3JKI33W6E1erMM
 XIjHi5ySy+ck/bzkdsdUydx3KPNT8jyZCZtr+AFeb/CKshwLygpGBrIhOyx2NzLs9snNcypnz
 sOQS7J2CsS8xK9VBKa6/pHp//GwXuxeaX8XZ4Mdujy51slRS86oD8AGB7IeJX0Ioz6rFBahN4
 5Hsn7QL6oVWQGGVf2cDh8IAoimeUEuuW/0hewb4mP3TFIARDpvdDos0BVJfZilKlCAVuHqTty
 AM9y2NzHoxLyBLlqsAPmn1C1K2p2Z6q0/P0uSRYmRk11JB9UNmvH43vSg9JCfLW8/CXc7LpOE
 KaiudKjJoKFTGbztbe5IDomHB6wOP+YR4j172kjwqxxVZgkUpxVaaXxUXjw1WgWDDXJKhTiMS
 TBe+vwi4/qZH//hws4VXwe1IRvWz2q2t5eoBVdf7O6ri0uoeHptd8st/4K7z6Vx0Iata/BUrI
 aQmPcsmg85i6eQZPlqWopVrtwl7Qcn1tur1DiOp5rxK6ZYG1lIPT6edNKiqjzGmRxRyLTAgoD
 BfBqQ0BtPNL6EOas4PrLDjpYz/yfi7hi/nfFMcqA9fVgyKcoSrvyzmvu8hf0xxYox7KSqpRKc
 MUuen8Wgq+HwZxF+ClM0knUtAANkgiP0znFLqn+Gjy65m7930MHB9vJxyQ4ADOhg6JZya44fo
 vSLCfakdjIBMhIIusIOIb7NaOe6kQgQv8baXuXyXI4LKe8p2QwBdxcDhiXlzwFiCNDLUyeEsx
 7VNVfsmmDqx5meWqFlIKfUeoDXF2a09CSx2nukz8dkQ7uEGfC/YVDVrXHu4lTkBPiBKZ7DRNO
 YIBCt+bKqvJdMbTIcN5wbPnFeDDQdUDkLKSgBAbSoi0O6u4rgXB0GWwxEdfXyvCluItvgueSU
 V6l9Ch8/9H38nmn4bWmrTM15RDxI7ORMfvB2BxWw8bE9d2OyfkZihx+uVMs3G54JdkiDK1Po0
 T+Vxg+BRiMYO/K4j6yvv0lkwfTutySNKzLHfg740KOc4RG9vehRYLHDQ32QAbuPJiNYAnrzQ8
 u6f/xp27gmSPaDy7ahpCNSu4reNJw6gj10lDRZUB8v9N9UVPUNfWCqlhRWWsqNFtskFm4PFRi
 uHRoBDUtf4oEsUvlTgXH4xjPPFT/N/MXVnL0cfXNhda6OjfdQxA/3G7L4xKbRAGn5QB7KcxGk
 LLUQEMXvbXk4HsRWrUb4vZhVyM4rPnwsB6DxnS1t/GxqdmBpwWzv8SCQWmqjaEblBUdyUHThU
 NNcaZtT+QG6yxu8uU8ykIziRfNnuDGrgBcv15hGeOxf+6TXHl3YrO5Esnvwo0/Ep+7PFcQclf
 hi5ky/wU3UurH6sHmT9ENgE1sKWcGX5B13PGyNuDiyq5AM6SR8F+FQUdqo913sr8xaXNR2YPd
 5DBVxbjeKYNuRfaLoou5jVbcs24fnLg424iWOyKMK6M4YCQ8xf0ARYTI1V7lWxuMQj/tjr13R
 25tgtnw+NUoShOJH2f8vev2L9XP+i7/2snzW69V9NrOtGri/Zn8okGM+1GfJlZASp7o6sWf+w
 ptKIso/+p5egFb78dmO2rORKwjgP3yWiesJ4kNfLKVmhm2/MrzrlTRLev2Z1/QOriADeDxHEY
 bWvgaN40A9er8oX8jwYUaODWL79Q+tpJpZs4FRW1WTB9vkkZdct3vN/Gr/1EJ0m54k0NQWcfP
 ja4vkjg6Ocwfka6bNJHzUJE4pMSSVeZu6M8SGltHr6vJeICNr+q1bw56Rk6IAss78MFf1NGV8
 mIaY5VGhslZmXT38tGSaQ+il9LVk3tYweQBzK9buao/0PU7h26pLiDooDZS6LfojX09WxEM26
 BLMjNaggiVEbXYCZJwc6j9yIVDH1TLlKw0bt1TyYQCXKb3RRiarUFWbiEkO4Vp/HVB1iTTjyD
 Gv+ADV6imTs0yRBpaeveNWhm3+iOOANJ/8oGeHSgNSRMhyeluC5Exdlm/zduLikwTilkKMPKT
 F/Lik1JD7WjKIfmopuCCqcpcR3oZ4tjfeaD0m9tYSovdnUUHjjXxVzHERT67sDx9J2MeRuHEw
 qwi9oiKcEkMj03Mk3h6j+7PCv1xMfrYrqVd3P7zGqjETzWjHir6aaECE6NsqOs3BaevNK4pQn
 jaS9y/OcTaFbo+QjqTqimpHzwtpknlUPmg8sbUw1NHtsST2Z7Wp+foAdjvvYPlD17uQBRdTuq
 BN2nXDeVL9AGlgU8vrwrmt56Yw6TcbNTCaPqpMmrG6LWw2SHvjdk5jC7XhNqD7jI79G6WqMN1
 zV0gl265HImLJM6+LrhyF5hblukqDrBFaOQzDPeLhk+e5lk4BuMboq5nMwWWhrK6O+J3GmLRa
 F7k4TErxR3exs0Nak3wNgSHD7mbgoleROEwthLO4ack7bEiPmugVTaLZx06CujK++HhWU3PQJ
 KpM0hnDwiDzmQ3NYWfIFc6X2EbQ5aY8EpbpcQtyoLAFRwf1T+u0oY31Vr1RMyZ4OIJpd3jZ+8
 Y85XXzZczk8gpeLeycT4KXqkl54YVlhLX5DIQ2QzLxiy+uWgxHW2jzEU93WPGqkmVNbOEaa5J
 8bKuDf2RofgGLIY4nWd+YPnNwKOniqvHd1onPdBL82Brf+V/ySlfn/YZGsAH/HKakZlNKMazF
 rWos7EoVzsBKghnj2kC4KErxVVMWgx6+awsCpC40SPkNFizyTgZgklx9smRxWgSv1xHyOG4Q9
 BI9vDET8cgdBCYlxEuIGZ5aoaiDNlxXEXLJ7AKTe9MiFSmxM6mIb9NpMVsXfzmJZaFI4BLjLz
 2iB3Y6SqFmU82vvRMZ4xX8XvOxjyZdZgnl4nQe7TDPS/tqrYrkFzxRrVbC+s438zr8tLMyg/w
 tgOSr8WRTBfLMux3nPYNmzyM5v+y99Sh0I4QRbktZq4XkR5oP/4E5DPjKp5PR8B0r3JETJlHt
 fii27JM5sZy2mLBbqaS+V5QwgkjARGeqcWsH0tJ1wvoJrYuSlwjzokiuF57ANoKwlyMvegSEO
 s7u9EwW1vNSqSaytmyDQN7HQM6j615sB89XX/7iRugbce/2uTzsbwwxSsrPllOWUGul4l9fF5
 8r/VtqzQnDcG3ZlOpUNxnkE3j5R75m88Yh1iCPo1IQfQ/6Op9xvBPRJhGke21qsuOD3UcyE+d
 u57nXTWz+000aXllV0HJPcEmP374Dr7ANnOkqygY0/rSAVHfGBof1MAfDEEeuoeDJa6z5csqw
 oLgjp3u0T95IsHpvEAWjV0wRx8fL3EIFXrkxWfmTkWd2js/5F7z8enRMFoCfX8J1Vtoeim844
 yfoTCWLQGH+4m8276lq3lqcAzrv7XB3vUVZJJ0a5IJ1A6z7/EUF0HcUlHjQsbujRliM8jY7cb
 08MtM8dNTt33LQQ5bOA4DZQYiO6//W9yzrTyt9FFOzwq8YpKijJ6tRbKsPCzGbNqUqyfG3knZ
 rUllUnomYxdjr5WTQ352vmXq1YpWhr7StiPMxP6Yi9m7IVs+Zo5+jmcbXQECQ5w8lZcmUaLDF
 yzYaOtmFFvlUWCDStRgHPA2YIm9ZU1cAEkWGpwgBPHOTE0xX1HH1tod/gduJR+wGFN0UZBo6w
 wT1+VDBFWHAfwDOctGhycCLwOHrpb+BVsoY4qNT1GvOp5TlSPWTHS1+zrrQmOzPYSJPu4RExf
 MHLu/b2t6w5HL3zCUdpQo3ebHTt1/Eh6Nn54GvBmbeiyG516s4C6uMft6B+7hIVdYMlT7RNy6
 W+356rfS6S6ByNDg0u4jBraSKVvobuTBizX2u/Z0OqWMEn/TZ3d24iF0pssFpyRwcs7L91Grc
 DETwtPBRc2igswZwWk4Hf/6OV+a6gZvYMTizAq64jAn0P5Ybw0/vjftzOdF/GUZOqHoQhtLxi
 VMkSSEW9s2U0yhm2G60X/ctVqenGN2HZBZeIRBzaT9uneGdVyHIwgdkFmXCBDPNnnXEwu8FbY
 intiEI9CxlgUi6xSvstlIU3OSF/8aBNcNWnayf

=E2=80=A6
> Introduce fail_threads to handle stopping the threads if the threads wer=
e
> started.

Is there a need to indicate a role for the mentioned identifier?

Do you propose to use another label here?

Regards,
Markus

