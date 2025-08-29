Return-Path: <stable+bounces-176695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B45CB3B9DA
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27305A08462
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A52D2498;
	Fri, 29 Aug 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiO/j/fJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C622759C;
	Fri, 29 Aug 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466366; cv=none; b=jy4VEOFtPGZcjjtTd/kzwE7DKn5Am42ZBnVfUNuszaV/BcplN8TnrfousvWSejm79WovFOu9O0M3w/FurhpdtFUt2GdRe+G2m+gvUr3KN49YdzxCDCILmO0pKRAZrORQxWW58aG5/LufJW/xUDwTZ8Cy/36dvKELxu6AcuvtW+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466366; c=relaxed/simple;
	bh=wtkk33ip4Gxk3X0QjiQ1Wz5aaAIgrr9KrI7wfdEmyHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRhCAVVn9QGuaIg11rgZnWqcShe++5E6frwW+r2WWSvvzE/3znCknrlKaSxv4cSfqamisGMlkE+qx0k6uX2rOWsFgBveNvGYHZiZyH/HV67yVWUzBLlz4LuBnahGp7EBUDodUdkQ319hgYuGVBsUbbEqMRNIW5aorAPPh7zbCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiO/j/fJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A426FC4CEF0;
	Fri, 29 Aug 2025 11:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756466365;
	bh=wtkk33ip4Gxk3X0QjiQ1Wz5aaAIgrr9KrI7wfdEmyHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiO/j/fJzoIt9L3pGbiFUFmPN9meMKf7HXRUzASLqMmq3nZ23NFo33cUDPzBnHl+U
	 GSdqzMgictixBbSkgTo0h0WXQhAj3ako5I3Kmerf481T14LrxKG/4G3AE/mlHwwkGS
	 6i1brKwNmEaS3A5f5x1sNNE89fQPNfHt3cJcYkY0k9nL+KC+ZpdFxK+ovnxa45u4tW
	 YinuE8LU5OInuWWSXgMI1hf802gWeGlEInoNrLUn8vzo+39u+1trLxuJWpIJAFgmE/
	 jujMk718BnOIkt5NHs8kMahmhRp/b7wd5WFT7l5cLYFfm0KYOJvurdcIhipMOLTeWW
	 WBb4uwy5PX8uw==
Date: Fri, 29 Aug 2025 12:19:21 +0100
From: Simon Horman <horms@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, bacs@librecast.net, brett@librecast.net,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	dsahern@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
Message-ID: <20250829111921.GI31759@horms.kernel.org>
References: <20250828114242.6433-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828114242.6433-1-oscmaes92@gmail.com>

On Thu, Aug 28, 2025 at 01:42:42PM +0200, Oscar Maes wrote:
> Add test to check the broadcast ethernet destination field is set
> correctly.
> 
> This test sends a broadcast ping, captures it using tcpdump and
> ensures that all bits of the 6 octet ethernet destination address
> are correctly set by examining the output capture file.
> 
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> Co-authored-by: Brett A C Sheffield <bacs@librecast.net>

...

> +test_broadcast_ether_dst() {
> +	local rc=0
> +	CAPFILE=$(mktemp -u cap.XXXXXXXXXX)
> +	OUTPUT=$(mktemp -u out.XXXXXXXXXX)
> +
> +	echo "Testing ethernet broadcast destination"
> +
> +	# start tcpdump listening for icmp
> +	# tcpdump will exit after receiving a single packet
> +	# timeout will kill tcpdump if it is still running after 2s
> +	timeout 2s ip netns exec "${CLIENT_NS}" \
> +		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> "${OUTPUT}" &
> +	pid=$!
> +	slowwait 1 grep -qs "listening" "${OUTPUT}"
> +
> +	# send broadcast ping
> +	ip netns exec "${CLIENT_NS}" \
> +		ping -W0.01 -c1 -b 255.255.255.255 &> /dev/null
> +
> +	# wait for tcpdump for exit after receiving packet
> +	wait "${pid}"

Hi Oscar and Brett,

I am concerned that if something goes wrong this may block forever.
Also, I'm wondering if this test could make use of the tcpdump helpers
provided in tools/testing/selftests/net/forwarding/lib.sh

> +
> +	# compare ethernet destination field to ff:ff:ff:ff:ff:ff
> +	ether_dst=$(tcpdump -r "${CAPFILE}" -tnne 2>/dev/null | \
> +			awk '{sub(/,/,"",$3); print $3}')
> +	if [[ "${ether_dst}" == "ff:ff:ff:ff:ff:ff" ]]; then
> +		echo "[ OK ]"
> +		rc="${ksft_pass}"
> +	else
> +		echo "[FAIL] expected dst ether addr to be ff:ff:ff:ff:ff:ff," \
> +			"got ${ether_dst}"
> +		rc="${ksft_fail}"
> +	fi
> +
> +	return "${rc}"
> +}

...

