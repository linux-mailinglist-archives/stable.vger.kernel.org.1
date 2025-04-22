Return-Path: <stable+bounces-135197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DBDA979B7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 23:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D54462416
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE7277002;
	Tue, 22 Apr 2025 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDDlYEfK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A321FF2B;
	Tue, 22 Apr 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358571; cv=none; b=m08hCOZxre6kx4ad7O1MfVAJceM8Ni2Fu/1typfzKP1ajGDj1hxDtY/qor9NNvxxgjwT7DFbcOfjwVfud5Uthu8j0L0ucDs0eGMSs8qLNCtUz6ilWCwgu+AQzaEEL1tbNzrGICjGjMo0SNi1irGfCHycYaamzGArRVFKi4HMWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358571; c=relaxed/simple;
	bh=sG7YJMva/w4l3cfCNfOiczfRXXTwbAHBKnI5Bzj7KRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otJKMPVsGpXy6h2v9IRLfgWgeJC5TYqgWsMdbU1j1Ud+8xE/IoaLJXbaPqMrJg4VrxEmSPYdcm1zyNd1J6GO6OetYR822Gm900FRGk6SsOYIGGkfd1o7G/kKkkrL3e5u6FunzFiKlssuee+fa63CfufJSsQ4q3JmU4NCYSukRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDDlYEfK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so4856302a12.2;
        Tue, 22 Apr 2025 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745358569; x=1745963369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dYvt2Xcrh+kbYqRYnlS/5tyT+BexXkaGSTJNxwW1ck=;
        b=bDDlYEfKHrybz4D5fziRdAbnlktSssaGIjF7SJWhWbTXclq8u9Dv/LWcCgdrUicvi6
         S4eTJ4+2RdT+6odU6o/DTc6229rvFfd85dqZecwoYftyGT1iemnGFFqD/5qYKODAP3u5
         2VtYxvWCXyuZ38xmYhl8CRnGSSKiDRUHBtJLuDQR5URSrPnvTexjFquqpeG6/CwWeRf1
         +MU7DrkbWQ3rTZ1nhI4hHBqjIIbosADE6JAHsb0lszCPlJrRTFf+2846DDHfdsjl0EkQ
         vW8exvRcFWNEnn2RphjGK5JHHSYBhxHgud0utI3TYtsXgGbALQ8QAH7jlkFSwZLNs1hN
         Bxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358569; x=1745963369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dYvt2Xcrh+kbYqRYnlS/5tyT+BexXkaGSTJNxwW1ck=;
        b=dErwHoEzJVCMceAQDKc5+Rvomgd9AIWBTezjn458R9DJAZ4ngqEYkHxZcNSO1yBu2d
         0uiM1iSrzBTSmPZwyOheAb2+e5hcf0tmqecGWpA7X1gnVZrf5Q176eD6+DpDysSo3asx
         5yaBuYVpoIO7hG/eOVCrDxDFOkUUJbRzzJBC9TKoIhUW3HTFrBlqPV3BU1SL2j/0Qnbl
         YEsBUhjFLSFIXbAnE8R2Agjl6gmPd5WpwS40F80QM96YnUevGzVGgmbUlUQBrYlUnUXG
         m4HMFTnd0QKxFzQi+j+BZIxRdk6mfxKNKYtCIX1SyacLgm/OO05iBzmdDck8KmB2g+RY
         STFw==
X-Forwarded-Encrypted: i=1; AJvYcCUuh3tlBLlv23s09zdZPOIshP4sf2+0jMYlZDsWiibYl2zDb8jNn4zIUiNluSAWAnoYOxD31Ahf@vger.kernel.org, AJvYcCVLOqICqgf6j6ZampLk5Jl+JXKDq0rq2CmrQlReU4nwylS530rnADKrsEWBnvX0XE0QkMSYwRZf@vger.kernel.org, AJvYcCWn86Mq6k4v80TXf+XDO7Y6EKBqR/KNQClwWoLDJY3OTPM5az2V7BZrXzKh3sgLMUqmF7RKedrbYw/k6RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAojUkFQE/BguChfpn9hzNQ+gFGIVWhM6r8W2X9tM/1QfVPyE
	puZ3I34QjCbTxmXfkUU9HSicTi2Iq+mcjyc8dfSIMEDCpl58sDCO
X-Gm-Gg: ASbGnctTqT4mPh+i5LqqL7wjLW7AEwEhcVBFpg1kFqyndf8YXpYoe0TptYzkpeTm9S2
	jWPq+eYsfI+vBLDD3NdNkASMtgs2r/SaHVAe4tTuPYlUg/aoCxHbPi1KGsTqzmMxAQc0pKteTIy
	0pkeu6Ja6tGGIl6dM7ubL+pbKtl3cYtAR9fxjfTptqZRMWPG4zjqoJWHkCsfDTk6dplrKWvgY43
	W1rTocmL4hJJufgPd0li/Wunv8ShRY41wK9RlN06u9OmCuhzlEVUoYlPAzlqI1RGiqgeQIzwh4f
	OET32/vjgMt4TxOx7zr3NdKUKPIMDFRg+odFbOV27qmAtsrncafUBsk=
X-Google-Smtp-Source: AGHT+IEa5UJBk8pFAAEn17DT7zrqf9LgrhW1yVg3/4Nr/d7c82A8poo6UJuKjfvQ33n45llJ3lLYzw==
X-Received: by 2002:a17:90a:f945:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-3087bb57aa9mr27886530a91.12.1745358569302;
        Tue, 22 Apr 2025 14:49:29 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4a46sm90649335ad.147.2025.04.22.14.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:49:28 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:49:27 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <aAgO59L0ccXl6kUs@pop-os.localdomain>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
 <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
 <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
 <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
 <aAf/K7F9TmCJIT+N@pop-os.localdomain>
 <20250422214716.5e181523@frodo.int.wylie.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422214716.5e181523@frodo.int.wylie.me.uk>

Hi, Alan

Although I am still trying to understand the NULL pointer, which seems
likely from:

 478                         if (p->inner.clprio[prio].ptr == cl->node + prio) {
 479                                 /* we are removing child which is pointed to from
 480                                  * parent feed - forget the pointer but remember
 481                                  * classid
 482                                  */
 483                                 p->inner.clprio[prio].last_ptr_id = cl->common.classid;
 484                                 p->inner.clprio[prio].ptr = NULL;
 485                         }

Does the following patch work? I mean not just fixing the crash, but
also not causing any other problem.

Please give it a try.

Thanks!

---

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 4b9a639b642e..0cdc778fddef 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
  */
 static inline void htb_next_rb_node(struct rb_node **n)
 {
-	*n = rb_next(*n);
+	if (*n)
+		*n = rb_next(*n);
 }
 
 /**

