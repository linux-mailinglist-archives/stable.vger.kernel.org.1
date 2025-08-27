Return-Path: <stable+bounces-176510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9B2B384EC
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152C83AA547
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BDA3570D4;
	Wed, 27 Aug 2025 14:27:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67551C1F12;
	Wed, 27 Aug 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304822; cv=none; b=NgXekyzNSjv5Tle/m0eqYsyXdCBftQnzxTqYi8Dq8jqwGDmPewOfoyeLGIcIl67Ak+pakd8o0NaT+BCZgm5HgDTd+RM9uB7b2pBUJzEBG62vrqnNX2Cs5MiPP0L7FCtS/4hCnk0e9f7EGUOnoDwYjL3M1yg5JmjrR+Mrnf9ppmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304822; c=relaxed/simple;
	bh=QpuHB39nAGQwyhSesxsgKIlahRSa5eB803jWfbfWbxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwJkRfz7At+8vHDgvNe50O/S6Nd6iqM7UG/Cy1PFpCkhbrdvY9Zm8wHAXpWr5dRVfDNkTA0ectvddeqxGy3nvhwBzFPEpbsozG7nctszUPQNnh9x4ARloHe4FliI3qqCSkhj9mer9QlEhrFo7A4vc2bHFzwA7C/RbibSfOhua2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Wed, 27 Aug 2025 14:26:47 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	dsahern@kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aK8Vp6yrrIoQEmxr@auntie>
References: <20250827062322.4807-1-oscmaes92@gmail.com>
 <20250827062322.4807-2-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827062322.4807-2-oscmaes92@gmail.com>

On 2025-08-27 08:23, Oscar Maes wrote:
> Add test to check the broadcast ethernet destination field is set
> correctly.
> 
> This test sends a broadcast ping, captures it using tcpdump and
> ensures that all bits of the 6 octet ethernet destination address
> are correctly set by examining the output capture file.
> 
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
> Link to discussion:
> https://lore.kernel.org/netdev/20250822165231.4353-4-bacs@librecast.net/
> 
> Thanks to Brett Sheffield for writing the initial version of this
> selftest!

Thanks for leaving my author name in the file.  Perhaps you might consider
adding:

Co-Authored-By: Brett A C Sheffield <bacs@librecast.net>

to your commit message. I spend quite a bit of my Saturday bisecting and
diagnosing,  and writing the patch and test.

>  tools/testing/selftests/net/Makefile          |  1 +
>  .../selftests/net/broadcast_ether_dst.sh      | 82 +++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tools/testing/selftests/net/broadcast_ether_dst.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index b31a71f2b372..56ad10ea6628 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -115,6 +115,7 @@ TEST_PROGS += skf_net_off.sh
>  TEST_GEN_FILES += skf_net_off
>  TEST_GEN_FILES += tfo
>  TEST_PROGS += tfo_passive.sh
> +TEST_PROGS += broadcast_ether_dst.sh
>  TEST_PROGS += broadcast_pmtu.sh
>  TEST_PROGS += ipv6_force_forwarding.sh
>  
> diff --git a/tools/testing/selftests/net/broadcast_ether_dst.sh b/tools/testing/selftests/net/broadcast_ether_dst.sh
> new file mode 100755
> index 000000000000..865b5c7c8c8a
> --- /dev/null
> +++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
> @@ -0,0 +1,82 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Author: Brett A C Sheffield <bacs@librecast.net>
> +# Author: Oscar Maes <oscmaes92@gmail.com>
> +#
> +# Ensure destination ethernet field is correctly set for
> +# broadcast packets
> +
> +source lib.sh
> +
> +CLIENT_IP4="192.168.0.1"
> +GW_IP4="192.168.0.2"
> +
> +setup() {
> +	setup_ns CLIENT_NS SERVER_NS
> +
> +	ip -net "${SERVER_NS}" link add link1 type veth \
> +		peer name link0 netns "${CLIENT_NS}"
> +
> +	ip -net "${CLIENT_NS}" link set link0 up
> +	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}"/24 dev link0
> +
> +	ip -net "${SERVER_NS}" link set link1 up
> +
> +	ip -net "${CLIENT_NS}" route add default via "${GW_IP4}"
> +	ip netns exec "${CLIENT_NS}" arp -s "${GW_IP4}" 00:11:22:33:44:55
> +}
> +
> +cleanup() {
> +	rm -f "${CAPFILE}"
> +	ip -net "${SERVER_NS}" link del link1
> +	cleanup_ns "${CLIENT_NS}" "${SERVER_NS}"
> +}
> +
> +test_broadcast_ether_dst() {
> +	local rc=0
> +	CAPFILE=$(mktemp -u cap.XXXXXXXXXX)
> +
> +	echo "Testing ethernet broadcast destination"
> +
> +	# start tcpdump listening for icmp
> +	# tcpdump will exit after receiving a single packet
> +	# timeout will kill tcpdump if it is still running after 2s
> +	timeout 2s ip netns exec "${CLIENT_NS}" \
> +		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> /dev/null &
> +	pid=$!
> +	sleep 0.1 # let tcpdump wake up
> +
> +	# send broadcast ping
> +	ip netns exec "${CLIENT_NS}" \
> +		ping -W0.01 -c1 -b 255.255.255.255 &> /dev/null
> +
> +	# wait for tcpdump for exit after receiving packet
> +	wait "${pid}"
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
> +
> +if [ ! -x "$(command -v tcpdump)" ]; then
> +	echo "SKIP: Could not run test without tcpdump tool"
> +	exit "${ksft_skip}"
> +fi
> +
> +trap cleanup EXIT
> +
> +setup
> +test_broadcast_ether_dst
> +
> +exit $?
> -- 
> 2.39.5
> 
> 

-- 

