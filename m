Return-Path: <stable+bounces-176707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E9B3BC0F
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 15:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9842F1CC1622
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172C31A06F;
	Fri, 29 Aug 2025 13:11:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BB2F83B7;
	Fri, 29 Aug 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473098; cv=none; b=ZHyp1RWVaXXm8cbvTmZpr9xbdxfNMcRym3qrcgcc7PaHkJ4w2r8CWIMDdVMRMix4AJ/emQsi+FOqWSq4n5aaXxk5ywWkgavqWL0PpyZsFLZln1BHRcm6VBijz/cv1ogFxK3zVzj/F4VlfVvSzbK530hqB7Ahm0ltC2yRUfNLbrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473098; c=relaxed/simple;
	bh=IMyL2zJYuRhL+iIq44TIHd1FCwhV/8/85EwF6zC5KiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miHQkra5N5+PBQUBtoUgNZ0PxU3IO0oB0U6No7klzIA2c/KyqvEdGHgXnC4wMEanBs8KE7A8aUXk6cForJoPCwi4uYqgjNY4nivH/xQZbbjbP14App0E36lebBI2jcGaRdDU1CJSRzWSx+7JPB+kW7jJG8Nyd0IGAjLl82D+hBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Fri, 29 Aug 2025 15:11:20 +0200
From: Brett Sheffield <bacs@librecast.net>
To: Simon Horman <horms@kernel.org>
Cc: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	dsahern@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aLGm-G1JFxKH-jw5@karahi.gladserv.com>
References: <20250828114242.6433-1-oscmaes92@gmail.com>
 <20250829111921.GI31759@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829111921.GI31759@horms.kernel.org>

On 2025-08-29 12:19, Simon Horman wrote:
> On Thu, Aug 28, 2025 at 01:42:42PM +0200, Oscar Maes wrote:
> > Add test to check the broadcast ethernet destination field is set
> > correctly.
> > 
> > This test sends a broadcast ping, captures it using tcpdump and
> > ensures that all bits of the 6 octet ethernet destination address
> > are correctly set by examining the output capture file.
> > 
> > Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> > Co-authored-by: Brett A C Sheffield <bacs@librecast.net>
> 
> ...
> 
> > +test_broadcast_ether_dst() {
> > +	local rc=0
> > +	CAPFILE=$(mktemp -u cap.XXXXXXXXXX)
> > +	OUTPUT=$(mktemp -u out.XXXXXXXXXX)
> > +
> > +	echo "Testing ethernet broadcast destination"
> > +
> > +	# start tcpdump listening for icmp
> > +	# tcpdump will exit after receiving a single packet
> > +	# timeout will kill tcpdump if it is still running after 2s
> > +	timeout 2s ip netns exec "${CLIENT_NS}" \
> > +		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> "${OUTPUT}" &
> > +	pid=$!
> > +	slowwait 1 grep -qs "listening" "${OUTPUT}"
> > +
> > +	# send broadcast ping
> > +	ip netns exec "${CLIENT_NS}" \
> > +		ping -W0.01 -c1 -b 255.255.255.255 &> /dev/null
> > +
> > +	# wait for tcpdump for exit after receiving packet
> > +	wait "${pid}"
> 
> Hi Oscar and Brett,
> 
> I am concerned that if something goes wrong this may block forever.
> Also, I'm wondering if this test could make use of the tcpdump helpers
> provided in tools/testing/selftests/net/forwarding/lib.sh

Thanks for the review Simon.  Further to previous email after some more thought
and poking at lib.sh

We're starting tcpdump with -c1 so that it exits immediately when the packet is
received, and we catch this with the wait() so that, in the best case, we
continue immediately, and in the worse case the `timeout 2s` kills tcpdump and
we move on to cleanup. I *think* this is pretty safe.

Taking a look at the forwarding/lib.sh it looks like we could use
tcpdump_start() and pass in $TCPDUMP_EXTRA_FLAGS but I don't think this buys us
much here, as we'd still need to wait() or a sleep() or otherwise detect that
tcpdump is finished so we can continue. I don't see anything in lib.sh to aid us
with that?

That said, it might be good to use the helper function anyway and keep the
wait() for consistency. There don't seem to be many tests using the tcpdump
helper functions yet, but it's probably the right way to move.

What do you think, Oscar?  It looks like lib.sh tcpdump_start() takes all the
arguments, including for your namespaces.  Up to you if you want to call that
instead.

Now I know it's there, I'll try to use that for future tests.

I don't *think* there's anything here that needs a v4, unless the timeout() call
is thought to be insufficient to kill tcpdump.  There's a -k switch if we want
to SIGKILL it :-)

> > +
> > +	# compare ethernet destination field to ff:ff:ff:ff:ff:ff
> > +	ether_dst=$(tcpdump -r "${CAPFILE}" -tnne 2>/dev/null | \
> > +			awk '{sub(/,/,"",$3); print $3}')
> > +	if [[ "${ether_dst}" == "ff:ff:ff:ff:ff:ff" ]]; then
> > +		echo "[ OK ]"
> > +		rc="${ksft_pass}"
> > +	else
> > +		echo "[FAIL] expected dst ether addr to be ff:ff:ff:ff:ff:ff," \
> > +			"got ${ether_dst}"
> > +		rc="${ksft_fail}"
> > +	fi
> > +
> > +	return "${rc}"
> > +}
> 
> ...

-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

