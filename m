Return-Path: <stable+bounces-192784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46CC42E4B
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 15:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CE0E4E55D4
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC02B9B9;
	Sat,  8 Nov 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="L1AYuXN5"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5F8F54;
	Sat,  8 Nov 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762612252; cv=none; b=eOHNhADtEjiZqjhpRInF7OqgFzOtDJIBqsrnfuK7dx/7iwE0k1SK7lb/X4SvjRIPNO3uUrQd5Nck24NVctgbsALY9OUhHTamer5t3Zdq7k+UiLaZVikluBt0saTair4nDuuYgf1i8KWSQt16IKuii8Vs6JoOtQszWCzu4eLUnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762612252; c=relaxed/simple;
	bh=6IPtUJbJzE8XpnfYFuMq59jzeHUiSCdVZaEmuNd5LUQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=iQvJtBBXntDi6sH5KtqbY3EiSuqTMB7qpcHNfGEzDlcv+eFHFwJIcM8C82awXdyuH/pQz+rpuxZez7dsWfBmPyT+m1VBe90hr0UWV6r8ivGhaTTQxA0LQd2z7aWDYi6uGFyjSzB0Pl7/OGmvvSvBL7a8FEk5MAwWZDQVIKI+H9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=L1AYuXN5; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762612238; x=1763217038; i=markus.elfring@web.de;
	bh=6IPtUJbJzE8XpnfYFuMq59jzeHUiSCdVZaEmuNd5LUQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L1AYuXN5ce51+Wz4mZqZNHbJYroDA6wauSmjN9GBxRvRwGvIhIoqV2KsRGebvqF8
	 yzDrl1z3TG9uib7jDG5btUPCgd43PfB1gdrc1FSkvNYt1mccpenpECST9f9+TiwI4
	 Oy0YLcwUmT8pk2Y9fbUpzPyEplqbdxVututpJZsnOZPzm9dl2mh4CIkJ7LCNfbU4D
	 onj0pKE8OguOiLH02xBh3ETY1Od0wsMnhcfEAuAiwXP6puE/n2CpqHmwJr0eIRJbc
	 fcTwS2yyXa3D0eJy5RzLwmks/iurwQC/NT21vEdEsTMkRwjJVaRq0uBM3YR3GuWXP
	 Kf1V2LbWabYKC4vPsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8Wa-1vdeZC1GTI-00W2wX; Sat, 08
 Nov 2025 15:30:38 +0100
Message-ID: <630f7b97-323e-47a7-b4af-50978d4f1a71@web.de>
Date: Sat, 8 Nov 2025 15:30:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-mm@kvack.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
References: <20251108115346.6368-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] mm/hmm/test: Fix error handling in dmirror_device_init
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251108115346.6368-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:44v14SBETpli/qm8/ELghyCqY1BCMYr2ao9UnqZP2YiLmNtQi5c
 DOD3rpUedMBIrBvSDIGU107XXiZbUoV1+VD3HYAYTHMMQkWn2FYvFZyNJExowwjx/LxjSnQ
 v1ZntpVIMNf2u+vGfCSFz4gadnJMyPAkHwCgsSnfJ1w/8JAi2JUQHmIVuMz3+s7kPJLDdfm
 o7jX7xmOMnFuGH5JdAN7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G7udir24tHk=;kI/+8dh1hYDJAuejmxm0c+zsN8D
 M43L00tsXDkMnHJUDWyNjnfgLqAGEVkFOkfseKcCzVZiBheoZNosWHcd9wiZNE6w1AaTtUxN7
 fnSd0j/oVlevm+Y+5quJje7n165Zz47hY7VqitAQDY0T4g1BqFJ/+RswlAzk6QIB6tzy9Vnju
 dqqFOGDHjI0uAsrPZINfQgADuY+29pkHqv/Fan1XSinr5iORslf6zD+YoWQHVhhayXXVGszhh
 iusqs6wMVWyzPWhpyjYg1CN54YWBl4K16fsyQqj9oPAPDOl5Vle6UE/7hBxWDKai3iZnaeUoX
 +FpkfHXSRiC3dvJQw9EaWYFi+EphbXhzHW86qiXGWCSognFpFkIIUiN5KHPR+kadNiW8aEIYh
 62KWb7HXbOCk6QjkvcojiZcY0btYro2IuA2rpfxkpL6PehbFxuVKiiXSUOHzYk3tAYknXqq2t
 /72KMJCmIHCjmW0TK2j884AOwtgbDiQMNFbFJyZVgqCywHvdS5Ok3zg/cacMEEp0I0VIVKR8N
 2YF4XfDgmn/S6EI6uRjQMLPOsMfkV4A/Hymoec3pVx8CeTvoWN78hc0/lpSGbadQtRDx0S3Jq
 kA1yHgwJSvWVIjDPCXuhpPw59A4CdEktzHp0cGIgkyEkx+hoJmnZcuG/Yi4pb+n8jykFGeEu2
 k/y/iQYMWCGK2ArSI2d27LNAAKNtHrxYJHyHkLc0tlJ//ayPZBsICfI5FYFQxeYU0PjuI6tVi
 qqE+/yY4PSBTkUG4Yd+ALXvCuAdM4eA8TSD4Tc5aG2cn947xo5oxTTJdd0jfgQb1EZ6D34Hkj
 a57NtQbagowXvop/TOEWKO0febx+DUVW7kS9j+lLsOFuhctlxN5B92yZXCajrh70fAuKOjTyW
 6KYMcYJCHXXAEQ3QIgt59liwrah78tdWcucr/iB1NCDsOj2qQCnQ9rayKAvjdHacbrl1VFE0v
 kCh/SvyZuDeBxF/bfzHrs1df4ft5/4L7MBtcp2EfTOLGC+yyxuc+A0BErEjapTg3yMd1iXclR
 5kiMIqtmZlootOA79ero8GVtUKXM6kxpJkMAHPiBXgp/QHAKiTZTCaNSVl2LCwqsCSCKBWboB
 ccu/yy+blR674TjCU3IGRpEPhmaB+T1ncB6A7rb/57O+QFkEBYCxokk/9umhqBlESiW9RM9nl
 MbAlKFRSATLRKJzbgdnEBt9PTOKp+kdQo4ooU1GUmcDJJP7P6aRnXVBCUPzW91wcUfEmc4onu
 uHv2Ib+G52M2TKY21zLhA1oKGFjR7pPTWEHhsfTukut7/G7naCQ3uvTt9rZl+D58EyzI5QuEG
 mUWRnool4Vl+k3up/tdB1y/mgpayQyUOm0/AtQr8qshfNKClgsB+T53lMTfbtIWuNbAk+dKH5
 REPY9hboR+EodtE3jlViwW17r+5aVsTGSby4iMigkitMLN7Xwot8tS36I46SDbxdvmkMtjzfb
 klDTcmWuZN3WJGmXZj4fQwwCiH3ypjSIeEmOZAmuCIp17jw3BaJHMKFr4g1/OfhwOzmi6cI0R
 m1BP1tHyftLPV6cpndpGwJgcQljGAzeAMmW/Eob4s73rjavlFIfKKo1hmb6+9tQWTkjxc2C/+
 LCgzXl4Uo18OX8FVjl/15hxdfyfN1GGqe99AX/T10ww7YSEkhuFb+YtXPIxOt3NnbQ1ygMaRF
 jbxHH0mP0ZkAwrjKoQt+lfi1LI6C+L0u1FuIa4+UhbmhRg4Gfg/06P5ngb+xOrL9OID+aisTA
 1BpDH9+BJQRHEgY3Sj3gzxSvKBC+gIQCqP7534AM19J7FIkdROQxyEuq+thBOUfkhPrFOL1wA
 KKapClnEKSu4Bl018lEhirKb+nas2ENm2QWxNgRv9rr9yhIrK0RC8jDsQN6XiwskKg9tpcVy8
 I9kobwrtTkdLbcB0C8hDZJ38qkYlNhUr14cVDsMaASc3taztqQsiHS1nc2MLTxlFg+iFRSVhS
 dRTjCPSx35MUijdtv8XMxPkuh63MPRR5Y4RoKBxmnQM1NOA/SNa69Nk6CYYjmtfb7qrZ6ekik
 61LLW9Z5M1MneJ/IYYPbVJQ5uCvupVneD9BNM90y+uhggNvElHX6ybP5dZazz3lTAJ4vb3QYS
 Y7gdUEscXZdE+ejkJ8h5NsKAk6kqV1xFqwuGmyQv7mm3aJu1f2U1wzLvVzZsSYJBWdqzOBx15
 +mk4flXeOB5ZFeJuRttD01Ksuo+a4nJ5JlmdhZJbI9xKo7aLTIo2PaqNHx3oXnI/7cA6J6YXF
 2AcgkuMRJf/xg3+2J3oS7a+Zy8K+0Pi8q9fApDma/7eLJI8igGn4Z2st522p2SpMcRfv+Lswz
 JaDz47NNu/joaGXhZACYTLzn2HSx2SDXGmYKpFfKDcVhRIRe80EN3DLGKs5ErEpTcVNTQ7h4n
 LBHvSuq9n7s8igicjVwmNbMTzGpJM9oWaJ012UBc7E/WCSc/UV592WwTQ4CVA2I7Xh3HYdSye
 zdG99YR6gWWMLP6n0ud4OnFFxX3drXYqR2L0V9ZDZ/FfUSnp4+vBr8A/A/1sTpsK3AfjqEfwE
 LMlp0gqQoJstAjfHCuGFWqZ1sECYNQ5undVm0XwU1n3DFicxECH/KMsOFUfGJIMdAexlLRy8l
 2kTDBoDUe77hTYz/3S6qiOl8wYl2ceg/idwo4tXrsTFwm44qVOQnApQ0u4btc5hw5sCypo1YV
 SUGzU8ao3xeeQ9+SD+m7FuAEwkLIHErk5K3GsSfQDfns4hFb9ECj6aDlJhlQHtgpu67H4OPUX
 dqwycUqbpiDxwE0/c6loYKJeYLq4AxrC9jExnZdsrxlMwYwAYvepkXuSd7LEx7rEC75KxF+xr
 09ZrqVeqgOcEWZYawGfnXLEAw9qJh1ZLXVoBze/BN4CUE4CAePXgSvHYpqDrVVLukn8jJZodW
 MuOjZCZLXbWK2CXLSefj7CfbfLGbJ6kIrRlPAenky+w0Qw6LHv7EFPtV9x+Eo27PJtKQgsO0N
 /cHKqcQyGfLPDOoGX3aIw2+Yhy1e+EYtWRsaqvhwynoPbnelN2RVp9DUZUX8bBpt0qoigOE+k
 7ATGrwycYSSR0LdrMrf7FO8zUY0pftX5tR9IqE5wC+LlFu4linS+7TVlBOSrLyeKGsVFUU1/T
 jMM9Lpa4dsrJFb4Zo70MlZX/z5IsLrFojI6gbw4N/3xB9i4VSaclCebCN4To5hIsBTEE3ISsD
 52BfJB+++CSiQiPv/1drHxtkJ/4ndi88qGHKlXEiln3Yc/F86KAwdQss0semCxP7yHx+M05lS
 svqCuzU0Y14FtMdTTEuV9kbP9RrTRopt+BEEU+NrUH6hwXyyrBpmKMJz6u9PkbdkfkHwYDH/t
 T8M7jbPV2JJTgBwCckqJxBkF8JFwYlvS1lwf+UMOo2pRaMYaqxRNzr3KMMdAccOTyWuXMsR24
 0i3B9h5N8pSbDcNbLKpTZ9Q9ymM6HTanfarZPV5KG0EzjZakPFkr4JCwLtcYr3mQ0sehk5rEZ
 m/g5J+CD7ukQpBd7fNS42zanl+jYy/nHDgbUhgGDHE4a2iFORUU6jpj1rPGK63lJuBg8Vw5ev
 HJ7Xr99SEb79h0/aYzPL5cIHDJdgc9zbKM+ZunSTdgjBgQdFnNxavv+8OT1ouyL6sZcY5dB3h
 m5E8rH+9WSqGqAb+emDIBDc6t7Opbk4kHQswIsnjv+of9D/q1M/yR933xiONHVFuAjLtu8SNw
 iA/7RvEY8RCAvEWdxPY8c7w5gqOOO11damz7McKHS0Zl1VRDvG7J37kKK2YvwmFjl7NE+IssU
 i2U8x76SVHyxhf5Mh8Q5QDoEHC6El7bM934a3K71bGJDfd0t9aeZc+XMylqnfFVj0VFyPA3Fp
 GZTPmm+CYASXL5+o65vZvPhUM9F7a2UdnODbbzG5ONFLN2xpTtVzk8RIOIgzvVD8yGgk+5vOn
 idUy4m5mT7yx4v+b/GUUgSz1jURAE1aQqvsKTR6U3flLSC1g3YFop237f1bKU8tmya886BYDp
 nYQHVUI9KHYnZ87uVvx6FeclAfimBXwNjkdmaNmZ+5un6pASNJbWec+PD8yGz5czrxhPOBHzs
 PSu/meBofYT6JzKQM7bM842hUkAvaZdm1kHhXcUnNC1lP1uwn3nj0PnLOFb9CpETOSIf/yQ+v
 5usBuS2S0YshGhrEDfquAfgkbY93zN5/eJCNEoTyU+Sz0YyC3NwK0saqHedqN1I+hJLfg46Mt
 BPCShyr06b8bvSPxcTvD1Vp5ZcuDbVXHMt24BPaIK+JoNKRCUVu5ghXE+UAWe1Gs+MQYduOUP
 AiSZyLXBnshAFCWcnlsy3HktxreGkvyYxDrskK5JQgK4Q+IDsI4e4yodOrjdDda0uHnZaIxtl
 2tjGMuanq0nkbRUHT2KK3Cdx87LBIOkxHJ9oRPMQgnILaMVKOQ6qk9SQiuLlnL+FOG3BWsSAr
 HEuDXrFWLaH4NtkKBcoPTKNtV+dx/ernsnBSO26upnPsm50ityCCqBSDPG8TnPmIwQie/NuHi
 WPBK9buY10wA3K1N1O3AIM7SULAXTSW4KZMpvj0hjrfjCVO5HMjiIfMZQarB7mNKLc35KjbVG
 IwMQeZxGJjcAzW0RhJ1xfjYnPAgbPAlZVXCcPwDFWnOBwBBGuDaIPwJHE91fG5LfOVUeavwxo
 pSlOaJkCOUAZKDd97M5rrPBugpvcGp3F7Clli7b6oSeJgYRuOI5FyeOD9ArPw54kgtauGyqEV
 4twDVep7RhO4zw524BuQ6QJYtDqOX6ycTAkXy/9htbtGhKAHQ8Tl0LARNH2e3kGkOwqzJXelF
 Gz/8CRgF2aocbgmvVUzx0jBUlSL8bquLcEQa7gDURVrIVTYo5BFTSZjkHDytRq4dxzGvGDs6I
 R0fFo0K/RVwLrYbBwz8HTUAcxHzWwSGbsRMmE9qXB439K1CV3VM9NzOCk5LeJSanadwGgAxvM
 iO4dQ372ALn3fP/QLv5ohdGJ5MyDZYvyH/BDPfevoE1zyG0g4zW9C9C7+VCl/4refHknvxlyx
 rNqxRlCxzcVfeYKN/xCYMVGTBArzKFKT8KnW9ORmDcQajLznLDXL5PuZxirULIVtq6cQgyVld
 eRl3A==

=E2=80=A6
> dmirror_device_remove() lacks the final put_device() call to properly
> release the device reference.
=E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n94

Regards,
Markus

