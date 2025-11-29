Return-Path: <stable+bounces-197640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCAC93F20
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 15:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D144434219A
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE77309EEE;
	Sat, 29 Nov 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np2t0VYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F878F3A;
	Sat, 29 Nov 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764425576; cv=none; b=H7qiaJAIPg+WgNAVeIWkmO3gUD79FisQHz7RqTc7mhAmIC/Q9V6LPyabkskztGYm+uDlCSnob8aWgfc3l5Z/eBSEAZauUZQjakTyp0pKqWXqiKaqnZs5ubtI6wKyWq/QUC7XBR1oq358iqjazgnLlwJRDZuM0RpA5JiD/Xp49po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764425576; c=relaxed/simple;
	bh=/kK4Qo56+rfLS0ZM5UHB/qh23HZmv1r+PzCe0invxDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mdmo6nRw+ax2kSXKovmcWP6u9mkTn9pOb3CEhzBCiE5GFrJW/1zCuc1Uj6gOwE/dUIBhtNIQy0op826D9h94+xsuoGPnW1NzpC3pAtdVfzX+iEbhvyK/RqfUcjaEUWkqjMUgILlbkq/utKyf21NFIw7vVD/oA4A5+xBPy7e+4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np2t0VYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599A9C4CEF7;
	Sat, 29 Nov 2025 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764425576;
	bh=/kK4Qo56+rfLS0ZM5UHB/qh23HZmv1r+PzCe0invxDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=np2t0VYCAZFX/wVENepm6wFH9Ln3zuYnGx+9LmmPbxsH03rmVpbEM4BzN+Eiz8xv2
	 BL14/W6jN0H4pGZZCF2p8gG3iKeHCDQUpRZw4N+gIoVgKEpJ0UYZAWMn7iVHxyAJd9
	 qiqcefDSMEt+F7dzOsrHJR2NKXrLuK6CZfyfGaV2Lc4KWanzqSeU8VNUc3zK2vvF4C
	 hVGfjvqJMqLnU0NTLAoun2LFM4rJI8pOYOf5X1l3YwphkvtCwEBCm5yT4N8MlQ5Zqg
	 iUU5oclmljOHa1YY7gnG3ycGOn43RxLE+RXlyhBtx8mH1SYnoN8sOzOXxTtZdl0Ee/
	 ezTNOP3ytMA+g==
Message-ID: <3a78dd9b-1426-44da-8870-0e1f9fcb52c1@kernel.org>
Date: Sat, 29 Nov 2025 15:12:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
To: yongxin.liu@windriver.com, platform-driver-x86@vger.kernel.org,
 david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
 stable@vger.kernel.org
References: <20251128033254.3247322-2-yongxin.liu@windriver.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20251128033254.3247322-2-yongxin.liu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2025 04:32, yongxin.liu@windriver.com wrote:
> From: Yongxin Liu <yongxin.liu@windriver.com>
> 
> The intel_pmc_ipc() function uses ACPI_ALLOCATE_BUFFER to allocate memory
> for the ACPI evaluation result but never frees it, causing a 192-byte
> memory leak on each call.
> 
> This leak is triggered during network interface initialization when the
> stmmac driver calls intel_mac_finish() -> intel_pmc_ipc().
> 
>   unreferenced object 0xffff96a848d6ea80 (size 192):
>     comm "dhcpcd", pid 541, jiffies 4294684345
>     hex dump (first 32 bytes):
>       04 00 00 00 05 00 00 00 98 ea d6 48 a8 96 ff ff  ...........H....
>       00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>     backtrace (crc b1564374):
>       kmemleak_alloc+0x2d/0x40
>       __kmalloc_noprof+0x2fa/0x730
>       acpi_ut_initialize_buffer+0x83/0xc0
>       acpi_evaluate_object+0x29a/0x2f0
>       intel_pmc_ipc+0xfd/0x170
>       intel_mac_finish+0x168/0x230
>       stmmac_mac_finish+0x3d/0x50
>       phylink_major_config+0x22b/0x5b0
>       phylink_mac_initial_config.constprop.0+0xf1/0x1b0
>       phylink_start+0x8e/0x210
>       __stmmac_open+0x12c/0x2b0
>       stmmac_open+0x23c/0x380
>       __dev_open+0x11d/0x2c0
>       __dev_change_flags+0x1d2/0x250
>       netif_change_flags+0x2b/0x70
>       dev_change_flags+0x40/0xb0
> 
> Add __free(kfree) for ACPI object to properly release the allocated buffer.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add SoC register access")
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> ---
> V2->V3:
> Use __free(kfree) instead of goto and kfree();
> 
> V1->V2:
> Cover all potential paths for kfree();
> ---
>  include/linux/platform_data/x86/intel_pmc_ipc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
> index 1d34435b7001..cf0b78048b0e 100644
> --- a/include/linux/platform_data/x86/intel_pmc_ipc.h
> +++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
> @@ -9,6 +9,7 @@
>  #ifndef INTEL_PMC_IPC_H
>  #define INTEL_PMC_IPC_H
>  #include <linux/acpi.h>
> +#include <linux/cleanup.h>
>  
>  #define IPC_SOC_REGISTER_ACCESS			0xAA
>  #define IPC_SOC_SUB_CMD_READ			0x00
> @@ -48,7 +49,7 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
>  		{.type = ACPI_TYPE_INTEGER,},
>  	};
>  	struct acpi_object_list arg_list = { PMC_IPCS_PARAM_COUNT, params };
> -	union acpi_object *obj;
> +	union acpi_object *obj __free(kfree) = NULL;


This is undesired syntax explicitly documented as one to avoid. Please
don't use cleanup.h if you do not intend to follow it because it does
not make the code simpler. The rule of explicit (useful, not NULL)
constructor

Best regards,
Krzysztof

