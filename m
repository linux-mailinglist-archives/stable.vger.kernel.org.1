Return-Path: <stable+bounces-217641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xZohH2fpmWlnXQMAu9opvQ
	(envelope-from <stable+bounces-217641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:20:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B516D5A7
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A40E30530E4
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755391DF72C;
	Sat, 21 Feb 2026 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="hLCBrQ3i"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2589460;
	Sat, 21 Feb 2026 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694434; cv=none; b=gkNL6Ca9UbBN1gq7hnH647oonpzOiDizgmDEH1SJ4ScQ44txLelTFRrBJrV3/yaPFT2cYrdbPMurvXhKvtVrQitARGwxK9xOytgLHqufvBtRfiSjzyJhmmcfbRxNMzSb6KCEtve03GE0PCNVCKFgKzIMV8jfWNUxOz6iCLV69Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694434; c=relaxed/simple;
	bh=02k1G24sl1jawOIYaKEiVFWDdPmax4sAbUYQ66wDk0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nahRubi1uN30PbQTYYpDcwS5rZDtqfiHSsaTAx27hQrsa2NHtt6m981QHReuL7HQxKotV8ZI1xvzvD7OpmKQmMsDFYYwCGPTKxbabn4voM8hXNOiCb49Ezwb6h1ABICXswWEQ3wM4/EfGQv4TP42cenY7arE5vmAvZPCW5jmoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=hLCBrQ3i; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771694416; x=1772299216; i=deller@gmx.de;
	bh=Y2BZUHXjYYSeG4kfUFyUtWqoulhab8OWJbsxJCLB3qU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hLCBrQ3iC/HH2pW8qnr3xDQP/EgYvUA/Tc1BpEiIZGrAzPu/RmLRUX8+CFntwL+0
	 pV760P+o7vOgazWKepgH0t6jSW+fenfxoMJw9WHSsAyVrLIQmcKeFoYKTtIwAIGVv
	 e/mCQqnCi4wNPAVUpRmEPwRuREtr4/vGiQkBMlBNrLI/NCoE5W+BMBSWbGq/D7ZD1
	 +PReV8vJSY2bHNiVVfn5PG0K6NiAreSeMtQMJsTOTPwqP0uteU2AVwhxP83xr4sKH
	 iCMvLNcGbVLM2SgnWNrTIcv8UoxZH9Jrf00UbqBcw70XjcsWy/21vPIu3aqqc3VjD
	 0toKv8A8D7esc45msQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.28.88] ([109.90.133.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1vXNuj2CRd-013wJ8; Sat, 21
 Feb 2026 18:20:16 +0100
Message-ID: <40d3252f-22c1-4a24-83ae-68de825807d4@gmx.de>
Date: Sat, 21 Feb 2026 18:20:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "printk, vt, fbcon: Remove console_conditional_schedule()"
 has been added to the 6.12-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 bigeasy@linutronix.de, Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260221163924.4117536-1-sashal@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20260221163924.4117536-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vi74b2o4fyivmiYD800PDUyvCmP6DcZ5jrZcJcYqNRNnGTFVM7p
 PIAgjWQ1zKknRqXWhlcipITgSEkTiMjW6opbVkoy6qZ0O/e2TJFsp700vM6oGJ6xJMEQotd
 gPreoqWyuOkmJRBF7Tt5GQeQix4KnTDLyVL4+IwDhV9I/SW6cqFFNVJmA0L1GBqxKoxJKIG
 KhLzmmXhTb1Ripgq58MCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LrNMQh/K09E=;rFSJXx7/ALh1vADbxQSn6mBaHKt
 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
 DxRZQOoc=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217641-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: B62B516D5A7
X-Rspamd-Action: no action

Hi Sasha,

On 2/21/26 17:39, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>      printk, vt, fbcon: Remove console_conditional_schedule()
>=20
> to the 6.12-stable tree which can be found at:
>      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
>=20
> The filename of the patch is:
>       printk-vt-fbcon-remove-console_conditional_schedule.patch
> and it can be found in the queue-6.12 subdirectory.
I suggest not to backport this patch at all.
We don't know yet, if it may have side effects. Even more in older kernels=
.

So, please drop it.
Same for the other fbdev patches starting with "fbcon:".
Those are just cleanups.

Helge

