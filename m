Return-Path: <stable+bounces-241907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I1SOwMi8mm/oAEAu9opvQ
	(envelope-from <stable+bounces-241907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:21:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C010B496BCB
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBC3F300789B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489A37DE8A;
	Wed, 29 Apr 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHVjhNUF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A427B35B
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476087; cv=pass; b=oJVruQdsJDEGfQZMVZkl5oTSoxT/Qes61EXROAb3E3Dk2fpyT+FctXKiL2rDjaxlJ0bkRmkAyksYh0AVIoQ+9kP95pMgMQ4qRhT5/N0+niJ3v3ZmSVfCN3TvR7psTq1zxCeg0XCvRVcI3ubjKQEsJqgXd90ufvgB4eeCXCF5324=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476087; c=relaxed/simple;
	bh=F0LKnQYydEFVmmpjFG0F4ArdLOZrbz8l2Ink5YAL6Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdJNJHfCX2AbJ2mh36HwOipCu3mc5KiwCszOIoSUaUHaKdVQYQlG1/X/DJxRdA6FsHjcrJUqzIZt+w6JlFE9/eg4p4WqrsMys2p682kgL8LxwGDqKX1keRDM2acz5SX+FTNsKiP6yEVwa4gz/xZxyZc1bC8iwXUr5GWPhe4S2es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHVjhNUF; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64937edbc9eso11336749d50.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 08:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777476081; cv=none;
        d=google.com; s=arc-20240605;
        b=NuZ/7ZWR2jkNWavx3x+jQjALPGLpk3kCrajiOX6swSBDHrqpqhQ1FpB0QiBPYprLCv
         ph/lux77gcoARJ+hr5/9ekC9bovHLPoUF0IfqcTdZKsJ8KLElC/CPnkvtMnu2c9VZjhA
         jV8otdNcTgmqGtVElV1grdJumJrcJwVlprC3LpRqXLgnqE+fRYJhcWZliDogVFlJNC/i
         uemaIrA88StpbodWJdwzqGt74SlxlfY8Fz4313R24QeGe0qLcNI9qO36FyYODTf+l2YH
         zNRNNhMTwkdq86QX1PXPWNaTyJmwqbhqTj6WwmAQcYTYJcXXVbDzoVXnw8+ojWnQtJoF
         av1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CYcRgbXTHmNUItUJBfcu/cdStn3hD3SAzjFhApjzb6g=;
        fh=kBMN65ABQ0kT4hj89nL3H7RiCtru1MBbCxm1DgS6ucA=;
        b=BrYTdRER/EbYjTzugqpsF95fbaoVmLWWa7DZnl/zS5ww5y6EEW5z6/wITEJAsIfGJ1
         dhja1KHFN6ryToLc07ThGFDmsHo86otQNT7hM/Z01FFv5jaiDqVmAG/an6xnL9wkcLME
         9G4dyDqZw0PqadcTYnHoj/YmkHP0T2KqCNaoUvC+XkMTfV9DVGHUOqGGG0aHKlD5Vq49
         zympiQTRCtOKj1RuWA0Hb+3B3LnJacpR6qkRTANPHpywexfaMhuHWsE9FMQA/fHKD55m
         1N+FqODPG429eQ1fleSrmwg5BGcJdY74jSlQf49ue+jrNTdzHPSOHUqXmQ5vsQca2jnj
         WH+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476081; x=1778080881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYcRgbXTHmNUItUJBfcu/cdStn3hD3SAzjFhApjzb6g=;
        b=EHVjhNUFqW3dlEmuycVkIWpsAoxpo61CBPu7XAMnt/+xzvfg/9TQXphN0UqDm7Uhd+
         0umiRpjcWOHO4q6SZkbdJbyL9al0YMMOL9y5JIu0aIe9h3uPy6PuWLrBH5c4dleRBwsK
         39imtFLJu2x+0FhBslMA0dPZkAlNbxjdjTDqhtjVez4RPhGPhmF5VCTaI1slkCf/V8bc
         FUeU2+8Yd5/kWIicvHzK/+qiR+93+8keCedQVPL6VLrfcVagCL5s24kAI+BpQe5GgWcs
         jNhY8vnwyFsT3LYcPwwDqHXIYq5hLGtWjIOuVUMb7TWW4PvF5i8wBMA4x5ZtINDmDccs
         4fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476081; x=1778080881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYcRgbXTHmNUItUJBfcu/cdStn3hD3SAzjFhApjzb6g=;
        b=n87NWOTgxgahv8I7HF7ocLcWjlKii0YC7sfS1gh6HH3g6cqxL5oJc2i2yc54cCloQn
         4g9aTPK0RFBHvKymBa7yBRABBrgQPXKGSBYWG+Xpr7kmLHMf+FjAUO6qnkbqaeyAWESm
         2l+f+6sxbxAQ4XIZR5BciYzOlKQV3KqYyZgt9ogbXIx0DV4NnxomIDiTrr78A3m6ST+f
         VS8UK7jZQDyLQhaN0r6KzgqWO2u+JGMUHSMMlqGE4M4atET7gh3U21BfQvs/zi0nEuSg
         TM1qy9LTJcahweeiJuU7WdusqBSEobG0W1z9L4VkVrJyG1OOQVwswFhnxAxn+7a1W/ht
         jrng==
X-Forwarded-Encrypted: i=1; AFNElJ+lJhXwYZ+NPHKokEVKrU16igjn1oX5tvNb6S5iSz59VbKmNp0FRVnftp9ClJg3QuU85dnuX9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcS33xt1O85Uzwdr1KiYR3Jk+tlni30StgxG8bKMlU9JJXPfod
	2hQ2gDVHmensDlXuzTe+AlgSgS21UhSpVcbQ86AeJd1Ydn0vDscxM339q7a6DUKGOFa+X/s24Nv
	JsaGvHTEydSJ4pry+DG8VvcB1R1b8H0A=
X-Gm-Gg: AeBDiesPLIvulZGCWMrVMmTQVYGTCf9EMytL6a7er1H7s6jyNFG8gXy37vjE2Spzz7T
	To5LbcxfCzvamIeKOvn8VLCcrjhpoMYHDjD2EPtbYmdaCAnA6/b+hQzSGeC6B5bssfx4nuP6j+A
	tSoDGWnYyC423SJnKUIZcwENBztK0O3YddU75+qyB59PG+bqs4TseC/8zC6BLd+8mxpEE/q4KR6
	/pqMOzxVafnUqYmUHer8Z8oyPWCLGD8JYIP1ApiFKhWF360aEwzvFkaoHOpleTm4+u/g1w4T84X
	gAaAywoS3hgbAFzqbrYeP44RLo3cwhUkO8sZVXteuYYwg33HlVUR+5vgDlRVsoftVhK4S0m2CBb
	EDrqz
X-Received: by 2002:a53:4211:0:b0:64a:cff3:8f4c with SMTP id
 956f58d0204a3-65beeecf3e9mr5086213d50.65.1777476080690; Wed, 29 Apr 2026
 08:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429123802.1310681-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260429123802.1310681-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 29 Apr 2026 11:21:09 -0400
X-Gm-Features: AVHnY4J4oK22A47FRROvHNLoScTG-JkEQRDEopdcMvPE6dQIUXQ3j_XdrBBGTSA
Message-ID: <CABBYNZLQcTa2528KGOXHProu7E2O7WQey=i20-VLxRAG2hFvHA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: hci_qca: Convert timeout from jiffies to ms
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org, 
	Paul Menzel <pmenzel@molgen.mpg.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C010B496BCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241907-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]

Hi Shuai,

On Wed, Apr 29, 2026 at 8:38=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> Since the timer uses jiffies as its unit rather than ms, the timeout valu=
e
> must be converted from ms to jiffies when configuring the timer. Otherwis=
e,
> the intended 8s timeout is incorrectly set to approximately 33s.
>
> Wake timer depends on commit c347ca17d62a
>
> Cc: stable@vger.kernel.org
> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump =
during SSR")
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
> Changes v5:
> - add depends on commit
> - Link to v4
>   https://lore.kernel.org/all/20260327082941.1396521-1-shuai.zhang@oss.qu=
alcomm.com/
>
> Changes v4:
> - add review-by signoff
> - Link to v3
>   https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc=
.com/
>
> Changes v3:
> - add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc=
.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc=
.com/
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index cd1834246..89073adec 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1607,7 +1607,7 @@ static void qca_wait_for_dump_collection(struct hci=
_dev *hdev)
>         struct qca_data *qca =3D hu->priv;
>
>         wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
> +                           TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUM=
P_TIMEOUT_MS));

Well defining it as ms seems useless then, just do #define
MEMDUMP_TIMEOUT msecs_to_jiffies(<value in ms>).

>
>         clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>  }
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

