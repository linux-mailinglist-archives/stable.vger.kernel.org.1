Return-Path: <stable+bounces-183500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90227BBFF93
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 03:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C729A4E4A00
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 01:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A591A314F;
	Tue,  7 Oct 2025 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcLReOUx"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1857464
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801330; cv=none; b=Cjf8HR4UZp4dvGxig2TuQMA5dwN/iuPr4xZHBiJriTBZ2BuZxyQXTddBHdOCl3+6nJZZ1vXEOuiKqls6Wy8iQG2NQETOCUDaA7wkY4qfvTeG95FYMUqVr2kC27fESVa117r9uR3sXLiDzXdUF6EcmUfFM3bEOrBzHsXcqD249QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801330; c=relaxed/simple;
	bh=dTonZkeP2W8xwq64wKDM7p+9fYOwb5HtyFurNb6VBkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXBJWh8iw7vsbpn938WuItb4nAgdZRgtEC441KHZBvlz3Y8P2QoVBwlTJuauTmouN41mkT/9LdJHRLIx+QCYNoZB7aIvOTbBTwiz6OgkTNKu5lH1zRS9LUIMDuBcLaxnA8RuSxPikjqqXmRxz2cZL3PAZ3LH0cg4DpKJnqUlmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcLReOUx; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54a81bf36ebso842595e0c.3
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759801328; x=1760406128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTonZkeP2W8xwq64wKDM7p+9fYOwb5HtyFurNb6VBkA=;
        b=NcLReOUxuAHcNn66evN/ubwrP1r+1H4oFCWI37nPALkuwrwJDY54nq+YvWG90SJ2th
         fYeg0rwcPxJxdLcONBipO/zckjQCbmZbSDAOSo7/JTrGV6gi461Fn5g/kz1yYQIJYECS
         /Q3Uy9aeYm3qSM1Fzgy5P4x2INprAcgbu6t2DrjE8+ZgB6jVu7T824l2rau0UEwVth8v
         syHSuYFG+u5Q4z4C1bYT9ho97D0xOmDv/ogRRvlvYWZ6JkJaJIt2anT90LUPdG2otS3S
         ev66T1hyJfcczE3XzldyuxKxQESQqL+kEFLLaNiMtH2xj32DJ+NgVBq6b42kxIHnUbXe
         dDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759801328; x=1760406128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTonZkeP2W8xwq64wKDM7p+9fYOwb5HtyFurNb6VBkA=;
        b=ehHMTtYwwgFsN4bjTn8HH9SKPKMMnE+ckTySNQuHtWWvZazsjVjwBq066bpMarJ2n3
         FDfUCiq6Le2QBtNWf/RyhBc1H5IZJlJ3PRZK/p/Mkb6SDp3t0hYsRqp23nNxCpy5tsaS
         ZolzYyvmO60vnyp6XqooQFU1otQxzfa8WCBadL8Y4J6wGEDmfjsTUfN8+Ru0e3HlZfqB
         X1p/B+IA5Fy5ZfT/mcX+XHSIfwYVL+5SC9eLbS4lRm8Ss8734Ctbptux6UWItUQh+j59
         zSA4O7NxOiBYsq1Tq81/8fa63PUu0og0ZUIyTmgY0V7jQO0rvQkr6VO6GRgoCaopjAGv
         hgrA==
X-Forwarded-Encrypted: i=1; AJvYcCWjiXj8NArcqnOakr98xaXScbwtHhhj0M1N+ZPybpw/xB5gRUGTeOVcJKmIfZxe+Se1gQpjc3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVI0wyJphuwVyYY+lRzjvmd/RzselvCVjhU8q4hd87Ql5i+P5E
	d1Fckao4NJbbnUUUN9bQGSMgB7PpAM3GDfG7OQ5jf7i6RiXWZJ/uoUZQ
X-Gm-Gg: ASbGncsmzmPKDdZPi1MkvoYAurvwvgsKbgOvrmPmUoeATU3duaGtdN9JwqIF4wh1N2h
	P/M6EN8KQAVT9BywUyHPxtdvNlvZNYHJl3+ZCZFHCaY2qXAbibodo9m+i4A8La0GbjU9YSkd6y+
	Vl5BGxjsflgSG+1N9ETEPeYs2qpHVEFtTDgqzQ6mlL22aYn+peoJmC8bSnj/twBCdw0ANwoflQc
	7hW+KN49sDMCYtLXkgJAj2Tz7MeRX3JkJ5M1lMTIfd/4av8cMy8hPOHvnXropa4L6mz6Uzh3ouT
	tbwWhBSbegrRadfQpFNBYQlNzZriwS7OPdoCQgfK6+SgbDAAhc+8MCDwo5VkD6QLlgWKIPKEyUL
	5sg2uRJgAxfehBF8/dJu1267xaRBe5okMWXADErdW14y9Bys5lW9HNaxu00mOIZc=
X-Google-Smtp-Source: AGHT+IG/CuZVAES3BSHynINML/GYB9ctain2pBZEnoUSZafLAz/JojezFxB/4HIhRy7e/u9iBABY0w==
X-Received: by 2002:a05:6122:3bc9:b0:54a:a874:6e4e with SMTP id 71dfb90a1353d-5524e902014mr4641182e0c.8.1759801327865;
        Mon, 06 Oct 2025 18:42:07 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf64c29sm3436147e0c.20.2025.10.06.18.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 18:42:07 -0700 (PDT)
Message-ID: <8135af96-528a-4aca-8e11-7cdf038f1454@gmail.com>
Date: Mon, 6 Oct 2025 21:42:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: fix shift out-of-bounds in sg_build_indirect The
 num variable is set to 0. The variable num gets its value from
 scatter_elem_sz. However the minimum value of scatter_elem_sz is PAGE_SHIFT.
 So setting num to PAGE_SIZE when num < PAGE_SIZE.
To: Kshitij Paranjape <kshitijvparanjape@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 skhan@linuxfoundation.org, khalid@kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org, syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
References: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 13:46, Kshitij Paranjape wrote:
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
> Signed-off-by: Kshitij Paranjape <kshitijvparanjape@gmail.com>

Hey Kshitij,

the formatting didn't quite work out the way you intended. For the next
version, please try to send it to Shuah and I first.

