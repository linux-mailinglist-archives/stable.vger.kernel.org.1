Return-Path: <stable+bounces-212851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNHVL2lvfGk/MgIAu9opvQ
	(envelope-from <stable+bounces-212851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:44:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E6B8971
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88AAA300C033
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7BF335579;
	Fri, 30 Jan 2026 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVF6hor/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC924729A
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762661; cv=none; b=dQqhOT1yx/NWKzbKQq7WQtREyYPD7hBRVDsyypz+eulQG5NoTiqikbyNzWnkjE2l1QsIyaNGjwOIL8xBJi/r6hHlzmAmtoTa2kiJTDhMzSiaqyDNZGTirwtDfp4vqF8Ri6s4/p6jPWU1utN2B66uDOixdj+FXfvcQ0E1gYM5UkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762661; c=relaxed/simple;
	bh=Se2TZEtd1mmElnC/ZfubyC1jOuxzf4V7hbuk2QTCVwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx1MB8sqJgtBemFycCo9EqnOaWrtQwODtNlyMU2t46CyU9r8eJnDMSLGhazRTP/llpp7+h4070bhvK243/XkpQlMXOYsAEfwpgBn/9/IE/Y3qxJM9stNNnTVLHOp0f+SY6OEgxb1eY0CAZc97Kzhe1ctqw0G2KMaHbCSWxnP7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVF6hor/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359a16a400so1560548f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769762659; x=1770367459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BhdgDuWmGVX3Ii7iXI00D64FLe4zlVQ9D5T9rX3Mk2U=;
        b=jVF6hor/hxRKdOzus1zTjxtt4tv7p8w77QRqivR0TD3RSXs0H7tbYgBtDXdjYPXpi5
         OuPXS4/3DQlRlvmTqZ1/9IIDUwQ5Vb06jbN2FcLGr5b3LbaqdX1sDacZQNa7SO8VucDP
         PR54KodU8kvh2RWDIIY8GfRgKcLJe3SZCFVqHtkSE8PEO72d7BHZz7SCeqNk6BE+oNLJ
         UaFbCsxBmV9BH68BlfLllr8yU4K3drmFG63h+a8mlDb4Pbpeosz/+oZ6AeV6ALhIF7A2
         29rtEkYeiw+TwRUfrZpEFxc0WUtT2uX4T8poAG89QgZNStx36fPdx+hIMZ0/CEf4AU4Q
         sToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762659; x=1770367459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhdgDuWmGVX3Ii7iXI00D64FLe4zlVQ9D5T9rX3Mk2U=;
        b=jouxd3TlykcQR48bMaOomFi8YvyEHeEoEtFHra7IqflqqtNRQv7sJ2glP/aJIVxJVp
         TECDUT+8gemSX9kyHRfVhaNEwlBJ4F2VZEJLxkFmT0UG4wOYw1K//o6xeNONM6PuCTq0
         j1QVQ3mrG5U674as5qOPdV6icCyF9//N/26hoLQYulgP/6ZiZA0khd6Kvrr3rApAKmXG
         9KXzSKYeqGfOpXzJCY9XA6lr6fLEQC/0enMSuImcEizC2ecc0/hUjBwAod+viD909f5Y
         KkP1vDUaYACdeUt+jeN+zqzjiU6SsMRVrRS0XVBgq8AnMzIWJR6vhhp6b/+v2aGCmQiS
         6ZZw==
X-Forwarded-Encrypted: i=1; AJvYcCXHaxf88+H2lSP5vqao0Bk7RawA3JqFWO8mLK4zqBAwUt4sN0oc8feSJ+Ni69OzykseF9w9MLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbFtTpFHqsaJMXdpLJDWTaunMnD568SsWumQQGQvO8tRdeBcl
	TlqeHoIRT7t9lDPP0+NowJsKhs3f9rnVpS0jAO0Akel+RP1uVmwDESbOB2DEx8Tb7c8=
X-Gm-Gg: AZuq6aJ+X1FNaoBmGVvvIfzhskLvxyaNVl5fQfVgTIKAYHkJygjrHguMof6zeDNR7DX
	wj4cP66OWxIXy5+7649jiQLwFzGh5ix5XqQl/qKJiTEElu09fzNUeSAP8VeET3aiH26hgXejZcQ
	6POJHEE6LqY1WEs06qTAYFMhlT5QYOP2iuxENia0b3zOFIeyu989jCmeuEZEhiOMrOKaFOdco7m
	lFlRS04Unaf8DWCjiW6h2XOffs3gBigRJELz4s3vw4fdAk2X7gc0MsOX4VPsErz7K+uwxXyzbZp
	swdveA+D+xqv+fCPiX2PS39aLeF8TvzRiHJb67zZO7iEYjJGFXuTuuGeYEL5gPG5DdR0UKXP4ZY
	um/EpYAVuUtDJwkL26vNpHkApd5aebGjb7x99Fc7SjF+7GYo4/QvbAoSfEi/TXyApdBncOc2hhp
	33WT5f0Cs2EvPqkvNe
X-Received: by 2002:a05:6000:428a:b0:431:32f:3140 with SMTP id ffacd0b85a97d-435f3a81d19mr3457102f8f.12.1769762658743;
        Fri, 30 Jan 2026 00:44:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cfd4sm19785768f8f.25.2026.01.30.00.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:44:18 -0800 (PST)
Date: Fri, 30 Jan 2026 11:44:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luka Gejak <lukagejak5@gmail.com>
Cc: gregkh@linuxfoundation.org, straube.linux@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/5] staging: rtl8723bs: fix potential out-of-bounds
 read in rtw_restruct_wmm_ie
Message-ID: <aXxvXqZeZSHoivFH@stanley.mountain>
References: <20260129181541.72066-1-lukagejak5@gmail.com>
 <20260129181541.72066-2-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129181541.72066-2-lukagejak5@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212851-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 264E6B8971
X-Rspamd-Action: no action

Please, slow down.  Only resend a patchset once per day.

On Thu, Jan 29, 2026 at 07:15:37PM +0100, Luka Gejak wrote:
> The current code checks 'i + 5 < in_len' at the end of
> the if statement.
> However, it accesses 'in_ie[i + 5]' before that check,
> which can lead to an out-of-bounds read.

The line breaks are weird looking.  You're putting a new line between
sentences and a blank line between paragraphs.  Just put a blank line
between paragraphs and delete the extra newline.

The out of bounds read is most likely going to be harmless.  Hopefully,
it would be detected and trigger a warning from the UBSan type tools.
Also if you got really unlucky and in_ie[] was at the end of a page
then it could cause a crash.

This bug is still definitely worth fixing.

> 
> Move the length check to the beginning of the conditional
> to ensure the index is within bounds before accessing the array.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Luka Gejak <lukagejak5@gmail.com>

Delete the blank lines in the S-o-b block.

regards,
dan carpenter


