Return-Path: <stable+bounces-269609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1s83F/7ZQWpRvAkAu9opvQ
	(envelope-from <stable+bounces-269609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 04:35:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DA6D5857
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 04:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nHGwesjU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269609-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269609-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3EC03044A7D
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 02:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091835F19D;
	Mon, 29 Jun 2026 02:32:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F82853E9;
	Mon, 29 Jun 2026 02:32:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700363; cv=none; b=jnPQIUlog5vPpUIqH076jQM4KxjhPQkxvv5wn9Nz7HIi5kPZJUQSW3ru2xZJ+KcfmBybPzjwV/M5ZejjHERuwdgdMRQWKpH1OAUyJoi1SR/zeYaVbVgplDwqu0kTbix5VE9+dtpKLJsNn7YxcsBQHTH0eC92gOulB/Katge19T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700363; c=relaxed/simple;
	bh=GnN17H6SRBKR6hb60Yf3kz5VFJHX+q9782F+0B3duFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/jwnX2i+NaBhJOt7q8J3HSK5ktNTpM/XJ2lVOhPfk49u8pDiPOOkChag64Y2hAjHyzoEirnMYogBLGG9xhubQc2Hat6ao5JoOCHCnab8LCbDc3rH+KEAFLG5wySxBZqUc1fZOnlvpaHI4UlHRIJ8cvnQEcqXEHR0A1t1lrlspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHGwesjU; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782700361; x=1814236361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GnN17H6SRBKR6hb60Yf3kz5VFJHX+q9782F+0B3duFc=;
  b=nHGwesjUxO6XuY0TqFxmIkiTv0bNmNYDJPODkcAICoJjGczpS71M9W5c
   yfGcbnOXVEKX1LmaCTiTX+t9Jfciy8c124acMbkTDLvSLzDAiOCZjmyBH
   Rsy+ukTsYuS1HNOoo+mghKYu+KlODlIAXqlDtlthEdLR1Mc/83fTGmF3a
   Ni6lvClX01O5dtzwK8bwuYwiZ9Hyx2n8ebn4u4N49nPcX/jmxo2CMVE1y
   9CoqHu4eES7INK/0vosX6XdcHrJyS9CYHWBDKJzbz83GD012aUGrQsWaA
   VLBKia14gFBjCA7DcGKr5lcRmpXCYFES7Rxs9wdjX6nx4ETY8pHd0fg0b
   A==;
X-CSE-ConnectionGUID: RlQ8b5++RbyrVYFZ/lWTlg==
X-CSE-MsgGUID: SVuVmqMITTW/Ay4hFbihaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="82377993"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="82377993"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 19:32:39 -0700
X-CSE-ConnectionGUID: NjZUo6jVQV+ZdGJfWqcEdQ==
X-CSE-MsgGUID: ObzSnO0MRJO3mwJ9hH5T+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="249201539"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 19:32:34 -0700
Message-ID: <d29d83a9-4b29-4f1a-8b63-7308e09ab295@linux.intel.com>
Date: Mon, 29 Jun 2026 10:32:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/events/intel/uncore: fix PCI refcount leak in
 discover_upi_topology
To: WenTao Liang <vulab@iscas.ac.cn>, linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
References: <20260628111739.43731-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260628111739.43731-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:linux-perf-users@vger.kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:tglx@kernel.org,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269609-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,linux.intel.com:mid,linux.intel.com:from_mime,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 551DA6D5857


On 6/28/2026 7:17 PM, WenTao Liang wrote:
> In the inner for loop, dev is repeatedly overwritten by
> pci_get_domain_bus_and_slot() without first releasing the previous dev
> via pci_dev_put(). The err label only releases the last ubox and dev
> references, while the references from earlier loop iterations are
> permanently leaked. Fix by adding pci_dev_put(dev) before the overwriting
> assignment.
>
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Fixes: fdd041028f22 ("perf/x86/intel/uncore: Factor out topology_gidnid_map()")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Fix patch format based on reviewer feedback
> ---
> ---
>  arch/x86/events/intel/uncore_snbep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 215d33e260ed..cecc1ce0a248 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -5494,6 +5494,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  		for (idx = 0; idx < type->num_boxes; idx++) {
>  			upi = &type->topology[lgc_pkg][idx];
>  			devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
> +			pci_dev_put(dev);
>  			dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
>  							  ubox->bus->number,
>  							  devfn);

I have replied previous patch, I suppose this issue has been fixed by this
patch
https://lore.kernel.org/all/20260602144908.263680-4-zide.chen@intel.com/,
isn't it? Thanks.



