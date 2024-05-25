Return-Path: <stable+bounces-46177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286868CEFD9
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 17:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C1E28184D
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D0A433D6;
	Sat, 25 May 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kFy+sy66"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB21DFFC
	for <stable@vger.kernel.org>; Sat, 25 May 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651350; cv=none; b=tfSAANpquIg2VRwPAV1zYRSeORKXpWtvposI5o6rbrqOmYiI0IWl0T1/rxSiudW5LtyoFuqCVSII9jtp4FOiiR2S3XdPp6kfCPohY29l6javo96cHU82rHnx5R36xd6Fr9tXTPE//RFDGg1aOxuddjGoe4qTHLqaXhXKSr8Bo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651350; c=relaxed/simple;
	bh=yro5bH62vPMRV0sFUrjs85aZ7GXNPw+iDR9pthLTnb0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=rxJs4MOhwPkc7f0ntyM9/TBUOA04VdROjzJ1G1Q+1F9l/oan9V/bCrHibCC0OxCUgk4FADTMRBipsEVU3FPPnIKFWEjLsIcHjeAs4b+2Sh5QXrsoZKVHWheVkp7KgeAKv76/DThNbecLN5t7yPKZDrNAbgk+F5NnUtMEQBUsIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kFy+sy66; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bf5bbacc32so383200a91.2
        for <stable@vger.kernel.org>; Sat, 25 May 2024 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716651348; x=1717256148; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhDpJRr+NiOba2L5zicg1hNVe8uFX/mnqOjF+6RBmDo=;
        b=kFy+sy66PUAYuR064Nx8zoa51Da0KGtEJnvDimJPDObNYqbNCObvJZuOK+9h5D8EC6
         pkJTZj+oLVIoxH0i7l8ZTzsm1dNWq6NImWCBSjZ55PTHtT/x/uES8hBRh9YJdt1k7eQm
         wiKtpXnNVlt1UZXDyNXRfmrR93qzgVfX2UM0LKvsB6iKTCbDTzIr81x9QJvrszCzqqJg
         R3QbtZjFma5ASNYrOMVQXdq7XQ+2zKWz+9xb7OoVaMQtxxHgfpvD2RYW3p2ONCUYdNQI
         O794ew8GUzZ2UKKEIh6P+xJMzt6fkrSm1/32pdZkiY7uJSDgN8fapfaeRjzSVE/vA7z8
         chgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716651348; x=1717256148;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MhDpJRr+NiOba2L5zicg1hNVe8uFX/mnqOjF+6RBmDo=;
        b=hioWzmMl0RT+VrqeRiXaxze0yYlvYQjo/5wGQwHEicpS68eqIn+7s/qOFzh0PN0rFT
         7kXjxnCKdoCJRNgDlwRw1ATTfkBZhY9/tF8ew/hMuzBw75LxR7kVoV0j05KK6gY29Lcm
         32vwMRzxpFtH1wUpR9wiBvkmYpLfFjIDVwmCi5sipM1367lNoSEEGpt/avqajgPrhWNu
         wPI8eGeld6JQ5dfYSPjCudRWd9xXIHkVykXHYYdvo6+wBBWt6hRGxHJME0E0Pm14zMLZ
         piuaAoY5EytKUTLl4PvCuvKP+tZTfnaA0An7j78Zp3ROMug4rtU6cuS00ov9J7lf2ene
         O/Ug==
X-Gm-Message-State: AOJu0Yzr6PkPIe3C8G1Tq4xoE+jR6pR3UWE9SE7sUhymC/nxRS6mpgtG
	1Njf5f1fG5Z9rnJ8qYm2WzW/b79hPFi2f84YHYcvVs7bmYvQ/v97HfUE6J61pfLZReikfryqKL7
	P
X-Google-Smtp-Source: AGHT+IF+HJ6npyd7hSJfiScMKGMei+VIoo9zzQBH1Yfqewduol4W4xp3+PVCg/+sQBY+Dkqs72Bj2A==
X-Received: by 2002:a17:90b:4fc8:b0:2af:6b92:ff6a with SMTP id 98e67ed59e1d1-2bf5f30e8a2mr4827306a91.3.1716651348174;
        Sat, 25 May 2024 08:35:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f30b5e7sm3025249a91.3.2024.05.25.08.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 08:35:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Gun6wzJqKF00g2dGEgyHkgjR"
Message-ID: <58b31c8f-83f2-4350-913f-b2f2693fdd29@kernel.dk>
Date: Sat, 25 May 2024 09:35:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fail NOP if non-zero op flags is
 passed in" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org, ming.lei@redhat.com
Cc: stable@vger.kernel.org
References: <2024052548-prance-gliding-4f31@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024052548-prance-gliding-4f31@gregkh>

This is a multi-part message in MIME format.
--------------Gun6wzJqKF00g2dGEgyHkgjR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/24 9:05 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3d8f874bd620ce03f75a5512847586828ab86544
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052548-prance-gliding-4f31@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Here's one for 5.10 and 5.15 stable, applies to both.

-- 
Jens Axboe


--------------Gun6wzJqKF00g2dGEgyHkgjR
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-fail-NOP-if-non-zero-op-flags-is-passed-in.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-fail-NOP-if-non-zero-op-flags-is-passed-in.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA1ZjkwMDBhZWIxM2YxMGRmMmQwMDE0NDI3NWQ5NDMxZWQxMTE4ODA0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4K
RGF0ZTogRnJpLCAxMCBNYXkgMjAyNCAxMTo1MDoyNyArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IGlvX3VyaW5nOiBmYWlsIE5PUCBpZiBub24temVybyBvcCBmbGFncyBpcyBwYXNzZWQgaW4K
CkNvbW1pdCAzZDhmODc0YmQ2MjBjZTAzZjc1YTU1MTI4NDc1ODY4MjhhYjg2NTQ0IHVwc3Ry
ZWFtLgoKVGhlIE5PUCBvcCBmbGFncyBzaG91bGQgaGF2ZSBiZWVuIGNoZWNrZWQgZnJvbSBi
ZWdpbm5pbmcgbGlrZSBhbnkgb3RoZXIKb3Bjb2RlLCBvdGhlcndpc2UgTk9QIG1heSBub3Qg
YmUgZXh0ZW5kZWQgd2l0aCB0aGUgb3AgZmxhZ3MuCgpHaXZlbiBib3RoIGxpYnVyaW5nIGFu
ZCBSdXN0IGlvLXVyaW5nIGNyYXRlIGFsd2F5cyB6ZXJvcyBTUUUgb3AgZmxhZ3MsIGp1c3QK
aWdub3JlIHVzZXJzIHdoaWNoIHBsYXkgcmF3IE5PUCB1cmluZyBpbnRlcmZhY2Ugd2l0aG91
dCB6ZXJvaW5nIFNRRSwgYmVjYXVzZQpOT1AgaXMganVzdCBmb3IgdGVzdCBwdXJwb3NlLiBU
aGVuIHdlIGNhbiBzYXZlIG9uZSBOT1AyIG9wY29kZS4KClN1Z2dlc3RlZC1ieTogSmVucyBB
eGJvZSA8YXhib2VAa2VybmVsLmRrPgpGaXhlczogMmIxODhjYzFiYjg1ICgiQWRkIGlvX3Vy
aW5nIElPIGludGVyZmFjZSIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1v
ZmYtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPgpMaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzIwMjQwNTEwMDM1MDMxLjc4ODc0LTItbWluZy5sZWlAcmVkaGF0
LmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQog
aW9fdXJpbmcvaW9fdXJpbmcuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9f
dXJpbmcuYwppbmRleCBmZjZjMzZhZWMyN2MuLmVhMDA1NzAwYzhjZSAxMDA2NDQKLS0tIGEv
aW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191cmluZy5jCkBAIC02NjIx
LDYgKzY2MjEsOCBAQCBzdGF0aWMgaW50IGlvX3JlcV9wcmVwKHN0cnVjdCBpb19raW9jYiAq
cmVxLCBjb25zdCBzdHJ1Y3QgaW9fdXJpbmdfc3FlICpzcWUpCiB7CiAJc3dpdGNoIChyZXEt
Pm9wY29kZSkgewogCWNhc2UgSU9SSU5HX09QX05PUDoKKwkJaWYgKFJFQURfT05DRShzcWUt
PnJ3X2ZsYWdzKSkKKwkJCXJldHVybiAtRUlOVkFMOwogCQlyZXR1cm4gMDsKIAljYXNlIElP
UklOR19PUF9SRUFEVjoKIAljYXNlIElPUklOR19PUF9SRUFEX0ZJWEVEOgotLSAKMi40My4w
Cgo=

--------------Gun6wzJqKF00g2dGEgyHkgjR--

