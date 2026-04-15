Return-Path: <stable+bounces-238107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C+6HH9532nFTgAAu9opvQ
	(envelope-from <stable+bounces-238107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:41:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF0403F31
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A56F3009B0D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA436896F;
	Wed, 15 Apr 2026 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnomJd9M"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0334A3DB
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253293; cv=pass; b=m7nkx8X9IJ92PTiV0rLL4THwKhS2Z+6To3OrLjlbZUXJuHBLNCXoGFwDre4zjHZxO+QZb5vjMyOM4KYCfS8rSr19xkrhaQtA7k034ekIf+zX2OznZBOddAH1pgKX05lQlzhmxoBNe+KP64N1iB882IOp9cvFQFcHBwD2TFDJtwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253293; c=relaxed/simple;
	bh=XtvTXhSZYqUwWyop+bM9L7kSLPdbl+twBxtseI9Z8Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZev5rOx1Ng7QFiXqiKtjtGDpNYPzseJXBvOLxvsX9Xc+AP1AeQKxrD+NHsRJzKVwsTumCQO2lTzrrnPe7rv8SOG31i0tOv5w/vGaZkI2SzD23UXHx8g4aMLu6aAUcH8mHVH8SuKoVrLgmm+HrodUMsjD/V/lW89RJI+epmt91U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnomJd9M; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651b0eb2564so4376404d50.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776253291; cv=none;
        d=google.com; s=arc-20240605;
        b=Ijj58ryGGfWe/Uz+2BVG4h8j45Sw9w2nO9EnGxZ/xStieH5Brx5imLolIOBv3xoQfX
         cAQThzisJRh7v8iybNsJhDzJ0XcihcPddIr5OKnHardfzUaXyWwU39it15YZpAkeb19W
         R5VKi3y9HRL1Ei1Ij1Ewil6m5ljovW9opaAPegzt2uo8755BGfGD8RaUB9gohMtiT2Tz
         bbthldrbP1YM1oe50wugrHgVk6WprOzJpgeotA2arxU594TMGoZgyY5onqdK2ZuBUJhU
         HhiZchYJNLr+vyTrBH9rBtvJznBiMcxdyQ+6l3Tj6FFduV3zMTdn2CORNyF1+uWN5QDj
         6tTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h2zOB9TAg/s8m5HPIg6Gu5ZC7aBbUnPW4iigiNwSb9k=;
        fh=r1ct1ljIjQeZO3LzuPiZ5VG+gwAFf19efp1rQw492HQ=;
        b=RN5aELKuLwg3tmYoCGpZK+CdhD3Q22BHFVFEt1q3IB8UYB1DVtOaauYHYHCFYenERG
         bSNG8Bzz5YplFUEQ9/SGNAYhFDkHtiB9hGVa6jwhQSd093t1j8Ed70GXXVQ6VY/BZ2Uf
         5Kb8DF8xa4Xp8rHY/IYa/Z4+klBH8OzKSnf7GStOO4rf6lBrwfcd4UJ9Yklbij0eoW31
         Mo4OuY6HL5fz4bnU/y/vctJS9X0c/+lmgIqQd8arbmpgvBjccWTnj7EdLVH9eHAYfvXJ
         hUKT5SApUI0y4M63lxP4riZdj7WMZhaGuqml2A+5tuIKiIyPjma0GuErxum36skBe/UY
         vcVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776253291; x=1776858091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2zOB9TAg/s8m5HPIg6Gu5ZC7aBbUnPW4iigiNwSb9k=;
        b=rnomJd9MMJKYtKg7kuGDO8nEsS3VWRlvGHj0yt7ySsqUM3x6q0V6yX3PFc78oytbq/
         GcfO9YJNJVwsr2Lq6CgrHnx7Z2BBGCdbSmlQC9liUC4IwkfJepot5IbNehBXsJMb/05Z
         gsa+sWEyq24A7Ewn5J7AcFmKnZe4Htaw26Ne1xxfHkg8yOZhINWFLXmdomfiRrc5Wg38
         BbiZQ1XQjb/aY9cEczcP4GCm1KW+m3TrX8Jjp29vL/q8/xe2lMeBAG9achzjNEPhM8ha
         CiIrwqAE/Oam+x10t18OQJrUybdPT4m8G3jzNny3GlpbxgKQ9BGTTGaD8Ue6Hs+GEqxi
         tNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776253291; x=1776858091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2zOB9TAg/s8m5HPIg6Gu5ZC7aBbUnPW4iigiNwSb9k=;
        b=FpCvnawHGd42B0NL8obweUGeVx6vl59YwfmZkq0ao1L+BIUxALc4zPWdqSUdX3UtSC
         6TGjXiO6r1wsQf4uNgs0aLombg3Pp6ApRPHWEuodXmmzd0nWvdvn6VAxOUN8GVCIeCIm
         CBj4FTigf83lsoPSZHHg5ZVsylpuCZ/3dQc+ySouKtRgSN/MxhVLGY2phtGfT1ndAPb0
         f+xhnRvgEw55xDg8wCJ8Wc0GYxniqV3pBLZdIcq/8nDsZwO8CXaLuxmLQVgXrzCcrkfC
         zvCGsUA2hn5GJTp4YAjYGZEzjKui6y60bHvySzgZOEEw/VODKLgS98cowK33JUgIyXx5
         DBjA==
X-Forwarded-Encrypted: i=1; AFNElJ8v/pcJw9p8Aa7X9KKP3OjT/2DauNvP3SX71cZ6uLoYER5uVhmNdNKsZskKrL6JwBad9MOXsek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzomXPj8jg417RbpafSMAw7aUYEUMDPPFcqwlWumI6h2t3T+lea
	W6zqtFhAhJ5Y4Yg0VWFse90beFFNtYs/PhAcZupfKXlTwJHCDNWPmP07EC5TUt4HUvm5PI4Z2ls
	W8H9YIVCRi+QWnHq/r4uM/luMDIS2e3I=
X-Gm-Gg: AeBDiesrqA0+YS9s0ok3IW9bDuP4UNTxXuayXxWgrj9CKzM+Ji+3lEjnbtL5MnsPRYV
	qeZ7+UVo0uDxqflcMRTi82s1pCNhhYfm46EJeO2WkgvSc6L3u2/oV2es+SZjJGueNIKpP1B0vYo
	vP4AUvNyLsqVyZLXoMp7izz4jp3UoWILZ3yOYOhjfN/O9pHbqDf20nxYZDEe6adU1AF2dNon90x
	fJ8//oafkpG1FnZtHEo4GMVLqECZiIUv/pgsPJJfcVmu0E9+jpyh0BrY66O68PvXnjPlCk7LJnK
	oWynuPYaY9EZHfCK8NVzVdqQFK66N4W6o8oYcFKdyylQuUc=
X-Received: by 2002:a05:690e:4087:b0:651:b774:5f65 with SMTP id
 956f58d0204a3-651b77469eamr14707540d50.57.1776253290931; Wed, 15 Apr 2026
 04:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415032335.2826412-1-michael.bommarito@gmail.com>
 <20260415032335.2826412-2-michael.bommarito@gmail.com> <20260415045246.GR3552@black.igk.intel.com>
In-Reply-To: <20260415045246.GR3552@black.igk.intel.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 15 Apr 2026 07:41:19 -0400
X-Gm-Features: AQROBzBiK2K2kOfuGetdT2HWOxscLehtzCui_N48TT7VXvWcAO_8-a8BpIp726w
Message-ID: <CAJJ9bXwb+de7k3cYZ2nbX1bBFjLC_qJVS36UNfxwGBuPd_DM4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] thunderbolt: property: harden XDomain property parser
 against crafted peer
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Mika Westerberg <westeri@kernel.org>, 
	Andreas Noever <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-238107-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: DCBF0403F31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:52=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Please split this patch into 3 patches that all deal with one issue at th=
e
> time.

Will do.  Sorry for the verbosity and bus confusion!  Look for another vers=
ion
shortly.

