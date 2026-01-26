Return-Path: <stable+bounces-211555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBylD7JYd2lneQEAu9opvQ
	(envelope-from <stable+bounces-211555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:06:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F9787FD9
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 822AA3032F4D
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF813346BD;
	Mon, 26 Jan 2026 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1Zij63wo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE533346B2
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429163; cv=pass; b=MxqTTwQxneRF606VjQ1D+iSgyIRrhbWEeDAnucoeBy1sWnTxKsS5RRY+T+X8M963X+5zo9pSsx8VI31rIL+s0z2qDErQgV1FWlfU868o9dC0u1ps8mKpS6vZeowEbe1Q5XEvIcgbP4+lOGhTQHAazTMXnIPiUnp6YOR7mvPqHJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429163; c=relaxed/simple;
	bh=oP1w0AKAafvaItQXb6mntKKiwKfxi+SXpE5jsecUakU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUj5BtdIZFU3QrkDqGn0YpY60icW1JntWq3xfg3dhc0MxEq38sGZ7Aho/Afs3ypJvSoMDjGqueqNLrpQ5Uwg0rVEcdJRHOLB3dDhnuFMZhkzteOlm5hoae82d1m5KBxyNwvtnpdbFw/j63PumxLCYmeC65e63/MgBH0K473IQlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1Zij63wo; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6493937c208so3879894d50.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 04:06:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769429160; cv=none;
        d=google.com; s=arc-20240605;
        b=eFGkITeWFu+xmHR+eSfBbHcc0LUF0XizuXCeM3ItdKnTeUzbK1WEofUFfNL7QmHAuK
         74G7Q57mAVbkrMV5+0EBQHJhbUP5+4zfI3ZfJSOZewSSIOk/zcZYLOkZKBxT0IKMFAAe
         rjMCAYu3r1m1KaTA+S4rEDTPUitqntyYmHfZpWWX4NEIc98P0XplVjFZR9FfZpWpkkQq
         JDaavKy1yAiY9XqV8nRwEoRcV3OxFQOGYD8h8nAQHZSl+aCxA3mGXBqq6Sq3FNcFiAKY
         LBIuXLn74WenHyNL8Fxu9ck2xN/HXxeWwpjdGNz2nLEr3ItosRzAai5Z5E0PthRLoTM8
         I7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oP1w0AKAafvaItQXb6mntKKiwKfxi+SXpE5jsecUakU=;
        fh=LXmD6xMGNs0yinF6DidDRE4ov0a7pDwLNjM0D5I5Z+o=;
        b=h2ngqI/nlzpX3//boM1h8rP8K/uY719c4Cvzd4BySEUOg4LVENDPEiDZmlqydSmCu8
         tHgsN80xUiFpTjW10rVoIWIwQcK42A9omwQ2M3ZRShPoRblXpE/GVB6jcAD0LxmJQgN3
         Ny3N9otV41JJyNSw2cgHfHeDLnps2B6IX63UdEZCTGXkubnSYyMDrnqGG7MvpCt9s2OS
         mDafqASuKeu79wiK3kXx8PfyO7KK1kEWO1CJlPhvEOI5SUypQDmS2qlF6fcyhs89nYUw
         ZZg31OVhlMRbnGNkx3Ce4xyDsXuEwe0EElccu09XdpTt/7W5hVvfyTPYU1wFh7B7Jx9/
         IrxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769429160; x=1770033960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP1w0AKAafvaItQXb6mntKKiwKfxi+SXpE5jsecUakU=;
        b=1Zij63woQHziAQzHVfjY0y4htMadKSomdD1Gk1NuT2QFGYHzCpFCItWy+Zts0MuCO1
         BYO4/fqsT6nVR88qnIA8EzaNmSWKsQ4GRa3GG4D5IqO2Ac9RbS3MpIAeY7ADB/MEu0Sf
         zaTI7S+ja2WG81rq+NBhRVDbXB1UnEvLU87RqS4V76kvGI+LglESS4qK0MtLlYeLlkhO
         ope200MpviqKshoz2d9RbsV+GWdTFDvW9vDc2qDsEfjbEfGZWycEuZyXzAfjW0NFCI92
         V6n9j9osKa8lG+ivw4hgEe6WQ+iZzShBCFBRGUMN7ETUZEAWSaBuhIYCrZMiSwZa2iBY
         22SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769429160; x=1770033960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP1w0AKAafvaItQXb6mntKKiwKfxi+SXpE5jsecUakU=;
        b=QvX7zylum5bZ5r+fjM3raenEzHBDvDHuNLVtEnmar/dxWOsGkNvv2t8i6PmGHULzHj
         ydG+I/lS/+mFPf0W8X89iudz2+jKb1x7cbTyum7BgiCYXw60eUKUtWJ9Pox5soDaER/j
         +s+46cxPjUhQH6xIyomU4Seaz5T+ro5RYJag+0GnhtdI4WmcIiZVC/OQtw7YRRhPhF8x
         a2AVqeG0pl3+EINKMF62Juz26zAn3OxDLvFT/aiKe6OsK+9+kIOEh3WM6vdYEpvosywk
         bjKcT3nOZslWoWhA9ZP82//+5YXc2D+F73r1+A6Uk486+L2vd0qLmZg1xW4iG1bff4mv
         QYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMQQeJp1LGH5ToH0tn7did8JDM4JAxU5MJoFXnkFCYcklqKOABpF1Rvl23CUKbMUVS2XQbMZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6sXkB1EN0VrKH0WMxBqS5Uuif+tQBmPWFNtOvra6u8BA72JNe
	SWViDbuYHx2Mhg/bAkFWVle9Uir7esfzguaZZy16Nm9sbuRCW2Fc3Ho/3dqe9qeOD5XomeqI45n
	ouGi0sToyyNxz00oHIpAwj4Ju59amobmlRjJn8mKQ
X-Gm-Gg: AZuq6aIlvdXh5Dz+BTdTr1E56e+2LdVxl+q/WLXhR4UrEom/99qEjp9hBzpw7rvWuuw
	CMM8RCgfpANF/pp4sMRaJs7wRZ06oFWRBz82Ke19X6uG5skUHJ4XhTBkgWDMYFfFosIQXq9EzHc
	69kFReXK4rWtgB8dbexiwnWQsmuBS8oCG4bNTUIQGiEtes7dCXVymM0OJEmvR0alP6RHAF/r/cW
	1++8XUMmt5eD1mZ3tv44w0HW1wXIzUbM9lgZaw3YGox5e840vPz2JsWdWZK1cRLRJ2HC4sBuH7U
	1REPIZwJcg==
X-Received: by 2002:a05:690e:bcd:b0:649:44ac:cc01 with SMTP id
 956f58d0204a3-64970ca0981mr2713750d50.55.1769429160609; Mon, 26 Jan 2026
 04:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-7-p@1g4.org>
 <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com> <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com>
 <77q-JcImMG2fuQxj_GMUtYmaFAIuPrYMasj4I3aqIVID-Op24JIShBIPgt9kozLZgN4HvsGCS8Ez16mKq4Wq9juL1IOKydWUJwMwCYgHRMg=@1g4.org>
In-Reply-To: <77q-JcImMG2fuQxj_GMUtYmaFAIuPrYMasj4I3aqIVID-Op24JIShBIPgt9kozLZgN4HvsGCS8Ez16mKq4Wq9juL1IOKydWUJwMwCYgHRMg=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 26 Jan 2026 09:05:49 -0300
X-Gm-Features: AZwV_Qg1l52weut7CP9r6jdojpkdt_YToCFRM5o8ot5rEl30mGGPNQW9ipnfrBs
Message-ID: <CA+NMeC-65UfJyq=34_K9tzf9J=-XFPJqDe1BxLNZv0mnjkxZEA@mail.gmail.com>
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule list
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211555-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91F9787FD9
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 5:53=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> Should REPLACE with an explicit entry list that yields 0 entries return -=
EINVAL or should it be treated the same as omitting TCA_GATE_ENTRY_LIST and=
 keeping the old schedule?

It should be treated the same as omitting TCA_GATE_ENTRY_LIST and keeping
the old schedule.

cheers,
Victor

