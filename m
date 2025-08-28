Return-Path: <stable+bounces-176600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A5B39CD5
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96FD7BCD6F
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4671730FC26;
	Thu, 28 Aug 2025 12:16:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C126A0B1;
	Thu, 28 Aug 2025 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383378; cv=none; b=EFjB5MdfYKmSHEhPuhK6kj+uS1lmyUbkw3oag6nbJON/mzeAk+RQDDtDIN0fY+5bJRnLRV+peWuvWTmKsRXikn5jtKsKJHU+aP/wL+SuY/Zfff4ijadWU83jhvsfTnPIY3v3O3EtJfVaNsqbf0UJZu/OXmJYaLg70Bkw917gOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383378; c=relaxed/simple;
	bh=NRr4p5UmjJ61u49YVbocEKwjrCogbDuH0kk3m6hJTFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaGUjD/KbBIXtp35u+pnluzmKl26A8qu0nRxvuIxUcCWDsMyf57oiUSxQVzayJD2UB7H6dw4d38OHTezJfZBS9PgwUOHslPsOS1RTp1q2+SQt0KSyk8hVJSEMpvzRwdEhHwBrTBQHE84iuHZSX3dWODd5tZwrl6eAor85P+r7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Thu, 28 Aug 2025 12:16:07 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aLBIh9HvqtXnUdQz@auntie>
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

On 2025-08-28 13:42, Oscar Maes wrote:
> Add test to check the broadcast ethernet destination field is set
> correctly.
> 
> This test sends a broadcast ping, captures it using tcpdump and
> ensures that all bits of the 6 octet ethernet destination address
> are correctly set by examining the output capture file.
> 
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> Co-authored-by: Brett A C Sheffield <bacs@librecast.net>
> ---
> v3 -> v4:
>  - Added Brett as co-author
>  - Wait for tcpdump to bind using slowwait

Thanks Oscar.

I've tested the v4 selftest on a kernel with the regression and one without and
it looks good.

6.17.0-rc3
Testing ethernet broadcast destination
[FAIL] expected dst ether addr to be ff:ff:ff:ff:ff:ff, got 00:11:22:33:44:55

6.17.0-rc3-00002-g329af5eb13d7 (with v3 patch applied)
Testing ethernet broadcast destination
[ OK ]

> Links:
>  - Discussion: https://lore.kernel.org/netdev/20250822165231.4353-4-bacs@librecast.net/
>  - Previous version: https://lore.kernel.org/netdev/20250827062322.4807-2-oscmaes92@gmail.com/
> 
> Thanks to Brett Sheffield for writing the initial version of this
> selftest!
> 
>  tools/testing/selftests/net/Makefile          |  1 +
>  .../selftests/net/broadcast_ether_dst.sh      | 83 +++++++++++++++++++
>  2 files changed, 84 insertions(+)
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
> index 000000000000..334a7eca8a80
> --- /dev/null
> +++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
> @@ -0,0 +1,83 @@
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
> +	rm -f "${CAPFILE}" "${OUTPUT}"
> +	ip -net "${SERVER_NS}" link del link1
> +	cleanup_ns "${CLIENT_NS}" "${SERVER_NS}"
> +}
> +
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

