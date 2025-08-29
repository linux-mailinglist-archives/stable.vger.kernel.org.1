Return-Path: <stable+bounces-176701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B73B3BA1D
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5596D564C4C
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF42D6E59;
	Fri, 29 Aug 2025 11:44:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD52D5A10;
	Fri, 29 Aug 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467896; cv=none; b=LTpUezSiyc4RTfYKwWV/sbGzYvuhunZZF2Y240JBwEVBFuecNFALyPt9XG4Mj8xT1YfuqTQz1mdBlMkGbEbT+V04+bC117ELmDd3CMW+wauLgWOUXklq/r7W03A3eTTN388ygiL9ukkH70U0EHzGE8yM2EN+2TRzHyvK7aqJhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467896; c=relaxed/simple;
	bh=rWSNZmDoBwoJRt2diJ69HY8DPyP9382HG/KxtrMuzl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMnLBYUIKwwLbCKc7qUmGnq8HzYjTV4zKbTVp+4iC+MgudNvvzYSpM227UAsSe2N45baXb2f/k8uBfGhY9h94uBVVCHeuhLbL8cXrsf+eeR80uMlN3+jML5eBVEBEUPzmCc5dc5/LVuUxg0A2cRziJbZlxWwtIAVy1r+atFzCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Fri, 29 Aug 2025 13:44:38 +0200
From: Brett Sheffield <bacs@librecast.net>
To: Simon Horman <horms@kernel.org>
Cc: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	dsahern@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aLGSplLd9LjVzZOk@karahi.gladserv.com>
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

tcpdump is started with `timeout 2s`, which will kill it if the 2s timeout is
exceeded.  Is that not sufficient here?

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

bacs
-- 

