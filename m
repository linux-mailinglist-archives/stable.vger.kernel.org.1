Return-Path: <stable+bounces-223414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGAgE93Lq2n7gwEAu9opvQ
	(envelope-from <stable+bounces-223414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 07:55:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 533AF22A865
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 07:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11D053005320
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223F374726;
	Sat,  7 Mar 2026 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8zNd1SC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353E35CB91
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772866517; cv=none; b=t3S6JEI7VnwDys3RjYN96sTCZOFb1TH+EVjw8nhXuT4IWnXWAYMS7sHUl4mYZ4AFTRmW9DKL02hnSk+p3AGN6n8yLyrhzvC69pEL5GiPn3V4gStLVM+NEL+R/AwYFLphtSyTHixe8I8RDLoNltVZ7I6R+WX/+lvUD0GqHX4YgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772866517; c=relaxed/simple;
	bh=1KvS1cSshswY5RxXwlNY6YjqFpwsiw3e+bF0IeZmQDs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nD1L86mxjRGtDl4/n113aqX1kMPEE90Ma0/WZrTzFb6PBKcmRiDAfvHrQVnr/xEaRG6SQONsb/kcDIVw6kcsiKVHMw/IpqhqgkSodkt/Xd9asfa2gU+49LdjsLcFIOjLZKdneZ1Zfj6ONIx9A7UqCuk10gyCgQBIyCX+t+6J+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8zNd1SC; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79801df3e42so130184967b3.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 22:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772866515; x=1773471315; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KvS1cSshswY5RxXwlNY6YjqFpwsiw3e+bF0IeZmQDs=;
        b=J8zNd1SCo9F2qUe3em66I9kRhqovf2f5zMEIBRON80MFYUts2F3jbsggOeD2ZZYRHU
         h4UowjYSRJTg7bH37f2HiS0Y3kCrCUPT8TeCxTw/Yc7IVbBmYoovgZamTt+fcf5d3kG7
         DYju/7UNYyyDQUu5xOY36EOFsVFDc3V17xg7UcUVm7zl1ygbTsHN+0mDXU4IzQpD9RG4
         aOleSFB7FPGSn7ArOPB/e22UPhGTt5eM+V0qmnizNreaf+LbrdTcS9HWOlC0In7LqwFm
         vY+OFu1hszaViLtCb39+oukyerVi5tThVKrV4b1kaNBoAt+rWqlhR3Cmum9ifEdkFWqt
         B2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772866515; x=1773471315;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KvS1cSshswY5RxXwlNY6YjqFpwsiw3e+bF0IeZmQDs=;
        b=UCU4Us0O0PACKlDo0ycIZKfTZCJkOhdXQ3abfilv041GfwCVapdiNP6V/fzXoVfQXc
         GxIJIxnW26kXxjN3WD7B3ergj8b7e0Gs3LcRbKenIDfEbIRhLKX6wPmIWnZKEdQaLjqr
         /Ty0fDWZh5p39j5hCR+rZWWrdKMsW4+uRM0AOJriYmXcn6BgK65Qdu0dLnQtCoAYBGis
         pZIgmkko3fWUg6xBeYxocQSwSm8+0ZuWZPfoJUd7PhYZ2G5ivZhBa4rWSoJi8uUmGXX6
         LLGakMSQZRdIpTuzi1jhpfbZaXmNH4i1svjExHrOhSHgNwCGlaqLlQNGNbDWHntyW/UM
         ldqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW52XhfX/wUXuOVBaRIN9wabIm3VRMfRWwc21OpwWtszzlBrPGpWKN2sM8oxshQGB5U4zrTNcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgvlQE8YkyL6V4Zu6sywTlW522VM9mXCyIfJZOJHLFw6fKFvz
	2sahon6Nzvh8J3XRVd1oSoh5L3dkNq2McZCqf1xElHvn3mC63CBFST+s
X-Gm-Gg: ATEYQzxjfhZEIXT1Yfn7Lo+NDj3AQwLOoG8CE4Xwx+VTTv/pcqJT6tN6iXvFZrACzwh
	wXFX4w4+LzlQMO+MzrT9I88QufyABfEY7rmNQiDjfwPm78u3AWp9zFVvhd3jNDmuM+E0xAtFc6M
	cUsGGuIOSmSofWsowf/GGGT5Q0ILo9bJP9Hx6saRdqWJj6pEG8aBn7pHkF+LjOIs/mRNPSasAyq
	ri+Z3QRReq+aZg8fXVUwdPA8vf3iq2ky4y+NVdLbYthvdiixiJ1y4NBQrgIsSaA1G4X6cRbExmz
	sOIzhA/z2cOamTPVnrVIwkoV9r9LGmJ8xqZesUvBIgZCBnkGeBIOXFyL+MTONSwWsTCgibjaUEU
	c/Dq9c5pw9wTj1dcaICEzSwVg9V5KXiorcSyh9GCMmmjAfQ1pkZShn68vZp20MMxfp1KHGvEGEg
	vIIxeaR5bOgIX0cTuGtndSXJ6cPh0WG5qq6oC7Y6xalLVw76SZ8FEEf35leq7S3VbOQyy4G5VMz
	0J0PtJ3Ue5adN1/wZj0jHFJrG1DvhpZLJgs6wJRjjWW62OpClGeUEqPupa4q949cFY=
X-Received: by 2002:a05:690c:46ca:b0:794:c02e:f617 with SMTP id 00721157ae682-798d1ddc45bmr85688027b3.12.1772866515389;
        Fri, 06 Mar 2026 22:55:15 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:151a:1f16:9af7:946c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee69ed6sm17497087b3.38.2026.03.06.22.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 22:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Mar 2026 00:55:14 -0600
Message-Id: <DGWCQ95L9FW0.11AOY3NZF4U2B@gmail.com>
Cc: "Tianshu Qiu" <tian.shu.qiu@intel.com>, "Hans Verkuil"
 <hverkuil@kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] media: intel/ipu6: fix error pointer dereference
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Bingbu Cao" <bingbu.cao@intel.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, <linux-media@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260307030355.26840-1-ethantidmore06@gmail.com>
In-Reply-To: <20260307030355.26840-1-ethantidmore06@gmail.com>
X-Rspamd-Queue-Id: 533AF22A865
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223414-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,intel.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri Mar 6, 2026 at 9:03 PM CST, Ethan Tidmore wrote:
> In a error path isp->psys is confirmed to be an error pointer not NULL
> so this condition is true and the error pointer is dereferenced. So
> isp-psys should be set to NULL beforegoing to out_ipu6_bus_del_devices.

Just noticed typo "beforegoing", will send v3 correcting this.

Thanks,

ET

