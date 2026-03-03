Return-Path: <stable+bounces-222791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBxxNNF1pmnDQAAAu9opvQ
	(envelope-from <stable+bounces-222791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:46:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB41E94F5
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B840B3041A63
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBF156C6A;
	Tue,  3 Mar 2026 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="Q64lQmYf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E52E56A
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772516810; cv=pass; b=K5Pe5F/PdwILEfYEBpPhlirA9PBJ7+/LvuptuGrWfPC8X9328mZPNddwLn1QSqBMEF4MQ1/Di6vA2iFrfVbhyDs6vqYrGAr0qhTkKjnbVg0neowcxcWE+EkaycN98jcwIYebTNvKRJJiZ8QpL2H6i0KYf0O9Ia7X093o/SJ7JdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772516810; c=relaxed/simple;
	bh=zqTfeGktW3zyNAI5r6JfV4h212lR2l9+LR91DiG9UVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgbW7QjMZFNiCyS8I5xwuZAqpdmxAnowj1SVr3pMV0wTIa2I7WUS/RWghLKU3BuPm+anik/w7X+FtUzuSedZICiGHiv8NyFDHR5XN0kCqdLoFajxyKMWGS0zaMuYyRhu+XibzHwj602dFOJ5PHakjRABST3LzNj4hs1z6zp3/OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=Q64lQmYf; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-387090ae5b1so86618481fa.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 21:46:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772516807; cv=none;
        d=google.com; s=arc-20240605;
        b=JXCLAXlhaE9BwJ/FRl440qJUz/0+qgs3yJvZwFtBmpKUFJGx+ct4RlNI8cgN932fLC
         fczNm375pBQqV88bZR/msDauT9MXWaNU9avZbe6GqrrHlV8gYkv6NbAn0MKkTLnJpqXP
         rXHi9VKp1yhevAbG95RSn8cdriFRSPrnaaTX9FJsrGYyYSI4MT9I4wqZdEkrzmc/dguz
         0Oe9HUMF00tn6q/3R+bXryrJ8UEX+RKTxq8j58O8QnaxD66uTv/9Dq3nHZHLFWNXpCMX
         atiyfXPxWBZyiBhtOA9xYuEGdpdkoYHHCH71Yz209aJjhWXX3tpe53+i7JgjpZ5g+X4Z
         +41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=taIAs3AXYkzr7vIokYXTXrN/WN4WkhUR0T51l939rz4=;
        fh=9cC6xgEI6kWRISAzlxkXU+YkS2gJotRMeB1zzJZTCCg=;
        b=C2wGAwmJufaxVlWAMKnq8WWQa3uO3KlzBSL43GKSXkmUSLzGYHry3tvImXtsOlJum3
         mH3cvTAOvn6GqYKhMYzPDum3xtIJFWqe4xMA8DwRmlYqJuEjfU9Fbln0yB0aW3Y/wT5X
         rUz/2J0HHA4MZ11ku3+OnjXHkikHzota4p0zmzi4jWrpDSQHaHQiEXCgNoHK06q48bYw
         yowOoVkR9U4W3Nr9P+iI+1PAwI2OUgiirIlDybFQAAI64+tDAvIYtc8fxmc7w5eNJLHR
         Vzl23nPHMXkJsScftZt3NjEpfYH+SbMqWKJ/UrzwaNVB53rBOH8GBK/0OvOAKLmMFum/
         Qgtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1772516807; x=1773121607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taIAs3AXYkzr7vIokYXTXrN/WN4WkhUR0T51l939rz4=;
        b=Q64lQmYfpxRDVrmniTy9g3lPoxG/ckrudLW76Jl/6kcUFyr7MLjMNLPw9ijH3cTTnL
         wrtrZtXrwcQFZ5ZRCTakhicjNVgpbn5ypJqyDLavG/CoX3RRCOEq7I1sR4M1LpgDTfep
         wvtc/V4+FChGNDDaBLDy+rTwLX1I+rO9FVcritgzHytDbQMG2kL9GvQqGSvNIiao7K7t
         ZvsSqzvC6ys9pudZ5A42Dbwf6lGq+k2OMvkih3fqbFRvUsLe31N06xtMH7A7di3i0ECy
         hbBGyxrigu1SGJx3hJ0brc3QZuaLHaUFTSB8btikdeCKSxforo3f7Ep+Z1yRenkJ1ZkP
         HeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772516807; x=1773121607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=taIAs3AXYkzr7vIokYXTXrN/WN4WkhUR0T51l939rz4=;
        b=ddQEmAN6tTAsAi4e56YJdLlmycFEpfCv3WVLL2UI03kBQZc2VIaKxBv+cdYDGYNndp
         Cz8wU7p0ILdMt0PKcNcIgfBonnjxeK/nl0memwCawNpWBJm4p4U+50RtdKQGMLq5q2aG
         r8Jlqx0KCUKAhKFCqDdUKCcEmusvixdkM9HMbfYrR+kNjfyO3zhhEnhPbyEVyRX0DthI
         6cIKDbaLgV2TUg8e5sMRoJyDLbXqSZaSOxGg/ml+S2/F2jaUowAlcQAgtShe0AviqdDF
         U7vBBlVXeirMPL//2YiaXNrns7r+dc0fsMOltSPvcVLgI4grkwMKfyvWjdBZhqMY9pI6
         Z7YQ==
X-Gm-Message-State: AOJu0YzOouT6tmxkhEw0TR8YtIEwdlaoGuk9sRKgU3j6yy2CPvA1Qor/
	KTKlkxGtp64Mko0JC7dnzi2f42pxMXZzlJTbPW9/5ZzAxIV415pnjgunMYtpH3fuhiRsSClxB7Y
	oT4m1hWpJevRFsCTMnM/+Q66OSpY7uQK7yPcHHn6hsRpLWToKWSlw
X-Gm-Gg: ATEYQzz0Uz1IxLt6yKS0+TusnIab7+p+XykFE2nJQDgZHvBSWqPLJTHPYBPZZiD3Y+f
	Gzz3d3ncKMn+XFu5jPjbQ3XrUsygRNzUCP/dAgtWJlCkyizwXv9yJprvt89j8E2+SYvIWsD5OpS
	4XFqVehmW2ThchYxG6iL+7TTrnaiqL0aU79a7zXduemFKxi9Xvr1QzLjXkNN75OLTI71rjUEYM/
	9QEDqyGcdOd1J9sMhy7fKYjELjpE7/Q1zPxhSpktI5NCpPHjkKmkWMhHjrLIAbBcbWB516y08CN
	T0wv
X-Received: by 2002:a05:651c:547:b0:38a:9c3:f0ab with SMTP id
 38308e7fff4ca-38a09c3f49amr65707161fa.15.1772516807005; Mon, 02 Mar 2026
 21:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223172241.291649-1-jsingh@cloudlinux.com>
In-Reply-To: <20260223172241.291649-1-jsingh@cloudlinux.com>
From: Jaskaran Singh <jsingh@cloudlinux.com>
Date: Tue, 3 Mar 2026 11:16:34 +0530
X-Gm-Features: AaiRm52vEs1QY6VJNlxChyn9QoAYsMj43P9BPL_q_G8p0MBXaolgJYvIl2nS3rM
Message-ID: <CAJyTHZzRBH+MuBxJOW7CGiKLyt3DisvwYvmH9_=EQfD1srf+1w@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 0/2] Fix incorrect backport of nvme-fc ioerr_work cancel_work_sync()
To: stable@vger.kernel.org, james.smart@broadcom.com, kbusch@kernel.org, 
	axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 37DB41E94F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[cloudlinux.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudlinux.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudlinux.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222791-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jsingh@cloudlinux.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudlinux.com:dkim,cloudlinux.com:email]
X-Rspamd-Action: no action

Gentle ping.

Thanks,
Jaskaran.

On Mon, Feb 23, 2026 at 10:52=E2=80=AFPM Jaskaran Singh <jsingh@cloudlinux.=
com> wrote:
>
> The backport of upstream commit 0a2c5495b6d1 ("nvme: nvme-fc: Ensure
> ->ioerr_work is cancelled in nvme_fc_delete_ctrl()") to linux-5.10.y
> was incorrectly applied as commit 3d78e8e01251.
>
> The original upstream fix moves the cancel_work_sync(&ctrl->ioerr_work)
> call within nvme_fc_delete_ctrl() to after nvme_fc_delete_association(),
> so that ->ioerr_work is not running when the nvme_fc_ctrl object is
> freed. However, the stable backport mistakenly placed the
> cancel_work_sync() call in nvme_fc_reset_ctrl_work() instead of
> nvme_fc_delete_ctrl(), leaving the original bug unfixed while
> introducing an unnecessary change to the reset path.
>
> This series reverts the broken backport and then applies the fix
> correctly.
>
> Jaskaran Singh (2):
>   Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_dele=
te_ctrl()"
>   nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl(=
)
>
>  drivers/nvme/host/fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.43.7
>

