Return-Path: <stable+bounces-176842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45874B3E2AE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3FE4440A5
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F9F31B106;
	Mon,  1 Sep 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP7ckGfD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBB275B06;
	Mon,  1 Sep 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729539; cv=none; b=ZcHZrjji0p/41ddodsiearln4B/J30gPtpYw0XDw1Jo1eIX7EJLSUTZ+RN+nKZob+MSFnswIXy5H8+UoXVHbraCx1+29qnxmDcVg4mMD3Oi+aYYo4jyB/Fk35qwyYNsrVvtrRHxE6+6sr8F0zwKEkqaiVW667faikRvuF0j0ud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729539; c=relaxed/simple;
	bh=FhUgOfj0bVqK5/3i7zuoKwiQE3KOdDKRZ53jKvi8vw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEwuO7eD/Fr7kJEXhshdnmnCr3fOgpKpYK9HotahdJNnY5zLfiUESYxIvTQj7V+Yn9fJ68xSdialrVNW5kzTlgHyq9K5wL9GcGQrFBxUXGdu9I4Dyrg5cLlh1lvTg9Ipzzyag6DBNxJDwL8ksxRrlcbtTfcpBf4/8EHqYj68fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP7ckGfD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b86157e18so9944625e9.0;
        Mon, 01 Sep 2025 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729536; x=1757334336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw91z0Ut3m8dlHDXlWeOzlhF+cYq0D8kuMtw5sH1QiI=;
        b=RP7ckGfDEoKYzzwiu1YIBIYSOlWSAv9h+itDm5azw5jdjTIRl/EkBRNWTk3ptHQTi3
         h+Wuw+RoRDecs/VomKPaStBp7npD8kqKDS8WnFsBZ+XBDo03ObU6uThUJkjW0Owi+5jQ
         PdD0C1pl3llTI9fmcpzIA0kc5oMnPs2b7Q7FpYFb4eu8HrK0pvqTlxi6OGJ/qMoQQ1eQ
         zsm4kJVHeytaiWtzp0yXxSXw1EEsvr3srNQ6XbnGtx5pATPl/IiAexqCik097479zNUu
         OeFlfCPVphioSMTOBXc9v03V4QfCTl06oADB6F4Sq3UfemwqpD/tx/pM3nMt/PjV6qqC
         Y6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729536; x=1757334336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw91z0Ut3m8dlHDXlWeOzlhF+cYq0D8kuMtw5sH1QiI=;
        b=U9n899QcKubbGvytCTPtgM4bHGPE0y1wUL9k526SC2t3ETS6zQliKTpP85h21n159G
         6MO0NtwO8iabhT75WCbbVxGc9mRRIbFHKZL3blbpmiqT4lQmq8Ngyj8/TH7zxLClybZz
         GEr1mU4ukYhT2dddUxs7GbBKt9sbqtVoIgMnetT0/YYfspPCtFfu5ZLcxGaoF1jm8IBG
         X2FOOAloJTu+I5QOVJu862ffZlvGlKvEHF55Z7HnhQZa1s50e6CkxGAQuKLQn8N1R6Qx
         Nb6XEbQpU3T/FEZYKa1S5M5pCrOuZsdS9zy6bOn3Ryu4EDpJYV5sYO+MfBO8/V5Tv58H
         QpKw==
X-Forwarded-Encrypted: i=1; AJvYcCW98qAK5nayRm2CxVSXWBSpoCy0NM6W3Fgx2jwGAxctKkkNk+Y6r0CKk0neOi1MOcHaKTpHm/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0g15CCv+1ThnhU++ten3JjmwwsVZWfFEHaazqw2TAYlPDsJIR
	Td3IgT3uEGWDQaOJ2KhbqexDWdQDJM2soHegNFPtiCu7S5a1op0k4pL/aeVPzA==
X-Gm-Gg: ASbGnct0y5zj+HvIo8PmRDvBwHsXdL9wcmvlOM6X0meGSG4/EVhJT0SKO6p5LG+/Y45
	4ata+a796Hk4Moi2BbAYCRymXzRojfjmf9qa2fi/Mw6+ikEHfz8jDfgB0CuATRxFQhbPJl33626
	ZbFEXos8sYr93u92uva0i7ZnE9MGXZ5VY/BBybsqJ6/9nBwPVFaPwxPOtGtuLwAs5x7zJ0VJvyc
	6E+TWxpvdpMW+pR2oH0eFEw/GqVc5FjfVg/zqJiI0t/OjOe4ukZNqof8FeXCao4fT2HPeteb7ij
	WOxqrDirMiJs3BFO5qGLQZsPz+iBgt229FAryYZxydKKwic6Ko0JR36lGU9sN1bzxOCwMPdvQ8l
	jc9mVxSHUhJT53C3oeVyOUhsoqV0IE5zVOApVKwuTb6/mfquU
X-Google-Smtp-Source: AGHT+IHsi9ja3WHonOVX85wIgauK7Hwgt3+Go3E2tK2J7q/AdL9TgDAOEAvYo7jG0qdAhkld7PlVfw==
X-Received: by 2002:a05:600c:4ecc:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b8555b390mr74970735e9.16.1756729535863;
        Mon, 01 Sep 2025 05:25:35 -0700 (PDT)
Received: from localhost.localdomain ([91.90.123.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e380b77sm159865625e9.11.2025.09.01.05.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:25:35 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:25:24 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Brett Sheffield <bacs@librecast.net>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
Message-ID: <20250901122524-oscmaes92@gmail.com>
References: <20250828114242.6433-1-oscmaes92@gmail.com>
 <20250829111921.GI31759@horms.kernel.org>
 <aLGm-G1JFxKH-jw5@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLGm-G1JFxKH-jw5@karahi.gladserv.com>

On Fri, Aug 29, 2025 at 03:11:20PM +0200, Brett Sheffield wrote:
> On 2025-08-29 12:19, Simon Horman wrote:
> > On Thu, Aug 28, 2025 at 01:42:42PM +0200, Oscar Maes wrote:
> > > Add test to check the broadcast ethernet destination field is set
> > > correctly.
> > > 
> > > This test sends a broadcast ping, captures it using tcpdump and
> > > ensures that all bits of the 6 octet ethernet destination address
> > > are correctly set by examining the output capture file.
> > > 
> > > Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> > > Co-authored-by: Brett A C Sheffield <bacs@librecast.net>
> > 
> > ...
> > 
> > > +test_broadcast_ether_dst() {
> > > +	local rc=0
> > > +	CAPFILE=$(mktemp -u cap.XXXXXXXXXX)
> > > +	OUTPUT=$(mktemp -u out.XXXXXXXXXX)
> > > +
> > > +	echo "Testing ethernet broadcast destination"
> > > +
> > > +	# start tcpdump listening for icmp
> > > +	# tcpdump will exit after receiving a single packet
> > > +	# timeout will kill tcpdump if it is still running after 2s
> > > +	timeout 2s ip netns exec "${CLIENT_NS}" \
> > > +		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> "${OUTPUT}" &
> > > +	pid=$!
> > > +	slowwait 1 grep -qs "listening" "${OUTPUT}"
> > > +
> > > +	# send broadcast ping
> > > +	ip netns exec "${CLIENT_NS}" \
> > > +		ping -W0.01 -c1 -b 255.255.255.255 &> /dev/null
> > > +
> > > +	# wait for tcpdump for exit after receiving packet
> > > +	wait "${pid}"
> > 
> > Hi Oscar and Brett,
> > 
> > I am concerned that if something goes wrong this may block forever.
> > Also, I'm wondering if this test could make use of the tcpdump helpers
> > provided in tools/testing/selftests/net/forwarding/lib.sh
> 
> Thanks for the review Simon.  Further to previous email after some more thought
> and poking at lib.sh
> 
> We're starting tcpdump with -c1 so that it exits immediately when the packet is
> received, and we catch this with the wait() so that, in the best case, we
> continue immediately, and in the worse case the `timeout 2s` kills tcpdump and
> we move on to cleanup. I *think* this is pretty safe.
> 
> Taking a look at the forwarding/lib.sh it looks like we could use
> tcpdump_start() and pass in $TCPDUMP_EXTRA_FLAGS but I don't think this buys us
> much here, as we'd still need to wait() or a sleep() or otherwise detect that
> tcpdump is finished so we can continue. I don't see anything in lib.sh to aid us
> with that?
> 
> That said, it might be good to use the helper function anyway and keep the
> wait() for consistency. There don't seem to be many tests using the tcpdump
> helper functions yet, but it's probably the right way to move.
> 
> What do you think, Oscar?  It looks like lib.sh tcpdump_start() takes all the
> arguments, including for your namespaces.  Up to you if you want to call that
> instead.
> 
> Now I know it's there, I'll try to use that for future tests.
> 
> I don't *think* there's anything here that needs a v4, unless the timeout() call
> is thought to be insufficient to kill tcpdump.  There's a -k switch if we want
> to SIGKILL it :-)
> 

I agree with Brett here.
I tried using forwarding/lib.sh but it made the test unnecessarily complex
and difficult to read/debug. I suggest we keep it as-is.

Simon - what do you think?

> > > +
> > > +	# compare ethernet destination field to ff:ff:ff:ff:ff:ff
> > > +	ether_dst=$(tcpdump -r "${CAPFILE}" -tnne 2>/dev/null | \
> > > +			awk '{sub(/,/,"",$3); print $3}')
> > > +	if [[ "${ether_dst}" == "ff:ff:ff:ff:ff:ff" ]]; then
> > > +		echo "[ OK ]"
> > > +		rc="${ksft_pass}"
> > > +	else
> > > +		echo "[FAIL] expected dst ether addr to be ff:ff:ff:ff:ff:ff," \
> > > +			"got ${ether_dst}"
> > > +		rc="${ksft_fail}"
> > > +	fi
> > > +
> > > +	return "${rc}"
> > > +}
> > 
> > ...
> 
> -- 
> Brett Sheffield (he/him)
> Librecast - Decentralising the Internet with Multicast
> https://librecast.net/
> https://blog.brettsheffield.com/

