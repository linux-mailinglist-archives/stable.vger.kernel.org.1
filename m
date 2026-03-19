Return-Path: <stable+bounces-227336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIwOHp8bvGlEsQIAu9opvQ
	(envelope-from <stable+bounces-227336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:51:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32B2CE09E
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0830302ECA4
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63C3E6DC8;
	Thu, 19 Mar 2026 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZXCyEom"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DD1459F6
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935403; cv=none; b=i8Tr5uoDwik30CpeLtjyhpDWXatZSbWKXl34nwpwsGFILQxwGs5tx///r0D7uQ+RRp84Z6MIXphRahtbzfXaGW1A8DbhPgTG23tOeVdxOPENcve1ADFK7ZXP9SgK1gV8fLgoAmqVQ9NXWZnesqUQ3O+NNp8Tfwgz2gtwX4s8lOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935403; c=relaxed/simple;
	bh=8+l8lygZ5HSagAb7mvzKhj0hA8Fc+SE+P5udB07cg+M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CKSN/gX/G4f2fFT5coeN0QCOxvsW9cWwYHJaTUvpEgAuxPJMH/Rya3Yg6scMMfqUms3jJwpu0ywKXLKLNCF4J9PGACfy8qErMJgyd8YH6leS1BzpqcVgwNvZq9Q9eieti6Mer8g1IJfIMvsBHWfaCJZnilLafC2He5NPSbARTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZXCyEom; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773935402; x=1805471402;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8+l8lygZ5HSagAb7mvzKhj0hA8Fc+SE+P5udB07cg+M=;
  b=SZXCyEomVvJGNu/yub0W589fIkw6SU98T2ne93IsXCS7uxYAe2GM3zFn
   QeTOZncClQBJqaSEb+cu2v8utJJIqQLDd9X+nTud9k196kb+hg2ZCYAMZ
   C6hbtfH8RTjH3To5HtrTxJRoyshQXrmKi2112NbPBPCgnDFZTxATnC7De
   FdJ1A6i5SWg7FotoAX5k/0mmMohO3Ohf4hMR+Tub+wOuhsTji3wleaZTV
   C5hT5XvcPpDbaJeBsL6l76TFM4ADLOTZ/fucusU87MuKEhBi8vwuCX6hK
   wWADbDJxMWHFPfW1fCB5VVezz4BH2yvOHIWUZk0iMafwjs4YrkjebghhY
   Q==;
X-CSE-ConnectionGUID: qqB5fkf+S8WT3Rwkje1SjA==
X-CSE-MsgGUID: H9/0WrpnTQKMLHMhDHBnXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86373913"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="86373913"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:50:00 -0700
X-CSE-ConnectionGUID: eLJvHXUWSD62gdS03ZD1Dw==
X-CSE-MsgGUID: VXNUs5TCSQq+Pm/U+8treg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218444429"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.189]) ([172.28.180.189])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:49:59 -0700
Message-ID: <fd3ab8b8-708f-43a6-84be-e6cf98fb2463@linux.intel.com>
Date: Thu, 19 Mar 2026 16:49:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: Re: [PATCH 6.1.y 3/3] ice: reintroduce retry mechanism for indirect
 AQ
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 Michal Schmidt <mschmidt@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Rinitha S <sx.rinitha@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <2026031701-reapprove-dollar-1839@gregkh>
 <20260318000947.379271-1-sashal@kernel.org>
 <20260318000947.379271-3-sashal@kernel.org>
Content-Language: pl, en-US
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260318000947.379271-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227336-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F32B2CE09E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-18 1:09 AM, Sasha Levin wrote:
> From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> 
> [ Upstream commit 326256c0a72d4877cec1d4df85357da106233128 ]
> 
> Add retry mechanism for indirect Admin Queue (AQ) commands. To do so we
> need to keep the command buffer.
> 
> This technically reverts commit 43a630e37e25
> ("ice: remove unused buffer copy code in ice_sq_send_cmd_retry()"),
> but combines it with a fix in the logic by using a kmemdup() call,
> making it more robust and less likely to break in the future due to
> programmer error.
> 
> Cc: Michal Schmidt <mschmidt@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 3056df93f7a8 ("ice: Re-send some AQ commands, as result of EBUSY AQ error")
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hey Sasha,

Thank you for trying to reapply this patch. Unfortunately for 
6.1.167-rc1 this will not work, we tried this with my colleague Jakub 
Staniszewski and got the following output:

# git am sasha_levin_ice_6_1_y.mbox
Applying: ice: reintroduce retry mechanism for indirect AQ
error: patch failed: drivers/net/ethernet/intel/ice/ice_common.c:1595
error: drivers/net/ethernet/intel/ice/ice_common.c: patch does not apply
Patch failed at 0001 ice: reintroduce retry mechanism for indirect AQ
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 780c847cd1ffb..7bce89ba0a6fc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1595,6 +1595,7 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
>   {
>   	struct ice_aq_desc desc_cpy;
>   	bool is_cmd_for_retry;
> +	u8 *buf_cpy = NULL;
>   	u8 idx = 0;
>   	u16 opcode;
>   	int status;
> @@ -1604,8 +1605,11 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
>   	memset(&desc_cpy, 0, sizeof(desc_cpy));
>   
>   	if (is_cmd_for_retry) {
> -		/* All retryable cmds are direct, without buf. */
> -		WARN_ON(buf);

The above two lines do not exist in 6.1.y source, that's why the patch 
didn't apply in the first place.

For this change to be applicable you can take the modified / trimmed 
patch you sent for 5.15.y ("[PATCH 5.15.y 2/2] ice: reintroduce retry 
mechanism for indirect AQ") and apply the following diff to said patch:

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c 
b/drivers/net/ethernet/intel/ice/ice_common.c
index a4d31e139..19d652d78 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1425,7 +1425,7 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct 
ice_ctl_q_info *cq,
                 if (buf) {
                         buf_cpy = kzalloc(buf_size, GFP_KERNEL);
                         if (!buf_cpy)
-                               return ICE_ERR_NO_MEMORY;
+                               return -ENOMEM;
                 }

                 memcpy(&desc_cpy, desc, sizeof(desc_cpy));

Do you want me to resend with this change applied or can you apply it 
yourself and resend?

Best regards
Dawid


