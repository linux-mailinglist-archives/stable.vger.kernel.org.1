Return-Path: <stable+bounces-249894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJfcOcKiDWqu0gUAu9opvQ
	(envelope-from <stable+bounces-249894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:02:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9758D2FF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9688C3289FE9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79B39B483;
	Wed, 20 May 2026 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnFeymiz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD63B27D4
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277354; cv=pass; b=awht74lUGdu6KfGtbFrh/AHCiOiSeRVW18mwtqEdgY0jWE7kaGhzO5IBnCFMPGFDa/sfUJd2oBaUG9lKOkFrfZJUgPzUhLEzpoLVZ6omuF5cv2u5C2WA4Cn1orYjJvJOykV0Vr4QkSuV0FkEIDc0FRG06PatcMWYnCJOkzVZvXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277354; c=relaxed/simple;
	bh=Pn58G6B6srU9x/l70tU0AeYbvxSf8sqlQAHRn4ijBj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5SeK1oB5Y59dkwIKxKLdWJtwdquhGplH5LsQ8NDnVNXFHkWnvENSx8LnzBh0MeeBAUkt5dDDxaTU89P+4yWEhELgzgzvkQdimFn2vqwXeCMX4Tqrl2/ZZ0HQ5XMVr12/ekEWX00CQXI8Sd+zJMhlv7hnhLb3i2e+IB0eKTUGIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnFeymiz; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-441209fb77eso2951471f8f.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 04:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779277351; cv=none;
        d=google.com; s=arc-20240605;
        b=iain9pYxvgSVmELc2i0sx/DHVFq59veldK68Bl98aj/iAX30+KMQKToP+utSgVQrFj
         vfnEH4/Frul1bbKM7fTn6kfqKZ0n3oIiwMIbFrwvHdc5FjnOtVMOJxMN6d9bZo8lmnfy
         x+p5EnS4N5ZfAkeXHaFgQj00JaoxLmrYhQ3/6HCTZYCLJfbsCS3/z75c9SZfoJS9gTJ3
         y/dsrkrarMGFIqdSFWp9MyNaJhb7L8xcHlwre7MXK9SM4a+ITIfmVF5QfZGtZcJqtbLN
         yeoUmvASehmVc9ngii9nILVXnREsCozJZoAFKxLXHtrY54nijBRL05k78BJMbTgv5/7T
         Wihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tvby5vcIc0d7JYF/tLQ0qqSxaYmfxcE7JARtxN849bI=;
        fh=bycwiGBN44G3G0T6BKjH+2DEExwhv2/0j05Wdi3MZUU=;
        b=F/AuUDGXVVpF5klQxLwBoq8Z9aJJ0RpFZsMCV5+l0O3wTYIBvRkuxySOncXmtgIzkh
         rhEdwgJjqT8ZO1qAr4SzWnNMx49A0cN/QqzdoMG3Gh2dKliFDOT3IMgnVpDpWAlhqeHu
         YRzpo79bOmigA/9FJmSu3C6L3VnUIH4TFBJ+Q3NuQzJ8XAxM9FWyZmmjAuwCjzK3ytqN
         o7gnzVWEgWtDr8Irse0pXkxqLB19YeKQm4mRWm69VyR1kITlbzVywo+Ut+XbXwvJvBQJ
         qyjkeq6EDu+DWoSOnEc/XDFB3DpcF9A+64dIs5XrcvvDm3kbXursdoea2WqzIx6dzWJQ
         +T7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779277351; x=1779882151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvby5vcIc0d7JYF/tLQ0qqSxaYmfxcE7JARtxN849bI=;
        b=hnFeymiztYYt2iaucl2i0wWCeXuyV0oHjRhTYaAILMRo2fhm35E8JkBiVt4dI0z90N
         iupyhP6LL6r57gaiomay+aPwlO2H7cRXmAON1o7tqYfgD5BN/JDurOpcyrw0Mi+hwD7c
         LrlWzb8CzQV64UPvc2/CJudJsrdmkQEEbUzpwbeL4RspLpIvAKdD0uIoc978pzgj0y7a
         t36fDNweOB9stlrxrHddHcxUDfRCbOHA4fJYyx75TrlXPXHDPRzFP89URJ4QnIgliJmI
         ZpgS/HzGUt2MZFr3yF0HlpYBqZYP2siTCfxmJsJvYy7vOhMrnQHU8vI/RsLIP9CCFpCK
         w8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277351; x=1779882151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvby5vcIc0d7JYF/tLQ0qqSxaYmfxcE7JARtxN849bI=;
        b=mDs9qL89nJcHZioSlu+6HMxIO2xpwvcxKcRp8xdtWrv0Go1t+WgwccjxMr9Ax1BWtN
         J4L4dR2I5aL9zbCWROHnfKmDJpKpVKZ+KLfgQxJWEmSEgq8/98g2udTN54OqDQBZuMyK
         FivkDqWaRomt5zBWxTDksonq2EDj18XcZsfCyo8N6cBMyxYYZPVB7RiyPDR08NxN+mxD
         mqvdBdyk3jrTZsvKSAxZtK7XJaATF5myaU9YojWFhZE7Xn3MCVAgWEl6Pid35FVlg4BA
         j8J1xlMoQ+sCJyvyQCXCqi0ZqNvml7O8ItvKyCSB+UhbmiRXuGziSAyvoitsH7SYRU71
         O+nQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HV7sYqxHPuHFZeJfjpPDSMlpP0/W1NooqbbU4CwJE5yJVqIiAtZyDrV50C+0V5tPPStB02S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNSgdQRMUFC0GmF9fv6W7IBeFrHfQdlLaeIHOkGIBHtNvmp4M
	NP9WUTBmlaVcllTXPrUeBWK0zzEbuiFyGwxIBEkGniH9tBO2Qbza6wtLp8ABQRj9OijYiUES5bn
	f5E/E5l70ElLfK6fX0BioTYHzUOM0cjk=
X-Gm-Gg: Acq92OE90TJ60Rjr5HlGITf/kas7SshJvEUCbfxI288YvnBkVzumH/SSJU7Nb1iuJD1
	MxhoiPHJGn91yWkr8kIsZ1q6SKheD2XbJL5w5LLj/HTOA70kLnegG+1lqpgOtuLmr5VKIPIzyMo
	P1/+8gOaOgQG+etHL+ZZIr+6c/W+pUxEow2/+G0ND894FXEtz3JJhpfsgTG+/IdWTAZ80YfnV7n
	bshTauwXrdO/fjALios9oSpaY4VFNzm2mhjMW9ODQvOV7m2RAx8uVi9gGjKjGHcVb8/8pdi/xXn
	q5SnQIrSTSQcL3lIfkmuFYhjRBQHZY9Ip52VfGSpW4b15bRS2uwxf/QS+EuU3pWChpCznbD8wid
	D5L3viAZKw/OHH4W1rgCYYdF3nJIsq/VPAbB0E8qq/vHuDJTebiNuEzZB6bIqE72DOFMb8KvXLl
	rSsbYfGAk92/+uSnPb
X-Received: by 2002:a05:6000:2283:b0:45e:6a3e:1ddb with SMTP id
 ffacd0b85a97d-45e6a3e1e0bmr28194289f8f.1.1779277350543; Wed, 20 May 2026
 04:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 20 May 2026 13:42:18 +0200
X-Gm-Features: AVHnY4KEGOKhvk3Hb1Ln7prlR14Nvmy4Se09kZ-X-cWXAhtqIKADV8xHe-Uux_w
Message-ID: <CALoEA-wrYjbkhM7EiS+f-JjXShpRJw+gqy2zzymq9Ue5t-XN5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] counter: intel-qep: Use devm_mutex_init()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Raymond Tan <raymond.tan@intel.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-249894-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[stable.vger.kernel.org:query timed out,ilpo.jarvinen.linux.intel.com:query timed out];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 91B9758D2FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 at 13:25, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> intel_qep_probe() calls mutex_init() but lacks the pairing
> mutex_destroy() calls. Convert to devm_mutex_init() which handles
> cleanup automatically.
>
> Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder P=
eripheral")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/counter/intel-qep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index c49c178056f4..816586893517 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -414,7 +414,9 @@ static int intel_qep_probe(struct pci_dev *pci, const=
 struct pci_device_id *id)
>
>         qep->dev =3D dev;
>         qep->regs =3D regs;
> -       mutex_init(&qep->lock);
> +       ret =3D devm_mutex_init(dev, &qep->lock);
> +       if (ret)
> +               return ret;

Unless you're compiling with CONFIG_DEBUG_MUTEXES, mutex_destroy() is a
nop, so a solo mutex_init() call is okay. Nevertheless the devm_
counterpart makes
debugging easier.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

--=20
Kind regards

CJD

