Return-Path: <stable+bounces-247733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NNpENcTB2ourgIAu9opvQ
	(envelope-from <stable+bounces-247733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:38:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E139B54FB6D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C193631F15C5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64548032A;
	Fri, 15 May 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIHGvpqn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7547DFB2
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847149; cv=none; b=S0c3opLYqFkExspAc+sararVfQbNv5HotV7qXAGPiheXkc/UqV8oZ/2GPZghfhq60AldsRJ1/jMrWjx+OBL4NhxFsxfjlk9gNFyIbQZKQrS5d2nbbhjHY3h++ujgq9lRD5CgIL8IxJIRK71g650YtglvvoVlv7pWnok+yOYTpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847149; c=relaxed/simple;
	bh=RRVW5gI8kawSQB508g7+8wnVnUFJGZvy97oFovd7pBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvqiaK2iB8Rrwfuj5G0DLI9swd4n9kcY/d99kVlWX06drE+BNsUcLg+wctMGiZOsuq9vOJ6VNSnjvyk+m/a5zQTvXL9poASrExl2Jf7ni28Hv3ZBvizj8IwxeXcjWcnGfbigN06/ZxHGQYicPyUvVYAx0A6j1bFQoZb9EVLqmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIHGvpqn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d87610513so88564421cf.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847146; x=1779451946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvLacU45+J5otIy9HSslIl+VuECz8126ekDqH8/sPwE=;
        b=LIHGvpqnEZYI0rFG8HaVqjjhJp83KSdV86SZ5tIC+4LUUBVzVXOnkVDkSE3jxoKzpV
         MCkJ3pyawuxQq8Rt2vxEp+BdIk/IHp4+ckhSwz5irJmAzUkpXmhepbswWh9pa4BIm5VE
         7oWX21/H3shZahCtHO4Ee2b9wo2lWerofaag1NOc7mHoe0C3Gn5FjUueO2oEHh/J+Hmi
         Ft3rfABNHbHJ/d1F0NkB99Y7HdkL7NzeDUFLnSRci5Kb4+KgZ4tDnTHreYViHTIuc5sZ
         Jeeo7ZFOidBs7btO3C4eNoxLpl1c3kMJYWXB6Ct7U1D8RSpmhYuv4TDdulaLIWtjbZjM
         t4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847146; x=1779451946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IvLacU45+J5otIy9HSslIl+VuECz8126ekDqH8/sPwE=;
        b=kl8UrbouBOBhZwGGGntWqv/IlbXRItPbpxvc9fsCSW0N/pn9UE0JCr2o0rzi+s4sah
         kEGOrPp5oSaLB4ZcBiNjzzruY+YDuSvHUZQ0Tbct8GM5/5A0MMnqEfXqmhKtjHspfu9p
         z71fEj7EYdwOS3JUJaWV1Dg7mCmRrjX+rMFAHwHiwhSiMKQ71GEAGekEA169DPTP1+iD
         ybhj/PwI56ZaXaR5NnT/FiKBtgmtEfdA5r2pQzCUEcGTSHR704ilA1sm9cVKVWmMa/rU
         /b/1/dlLn5odJAXz/cmBbY3djWICV0eKYcliwzCSel/G4jJZd57NJLcUoAjMsUkHBJgJ
         IO7g==
X-Forwarded-Encrypted: i=1; AFNElJ+qyeYVkG0FwKzhXVY7g4BYW5Z7srogPid3/PfmbtD7Hl8J4SW2MYDbmlqpAoeOu+BV2DRqoWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOtuk9zZ9UG4zgCkaHvLlD8sWnC25OJuBZoF11G/7Tknl4fW3
	UPC5PzyYhFRsP25+Yxs5VdzJULzWl+1GPqLhzwaR0msYKHZIKL6pw+tE
X-Gm-Gg: Acq92OFpHgxKma99rHCIFusx/lj0/UsIg39w3TT8CxKD6LLqXUn4Z/ggPeISi7dQwDM
	G/mgthdkrDPTuXPunBrjUWXH1JOkke8LF8LvRpbE3doFT6c4G3U6EOxi8+247X/2iYxwzxCa2Bo
	byxN9PW4mjZYrrawsjmF3DLC01iY+tJ6DcJJdtqAdtfrj96xZfcAGslHtVuuNeQSjmssMF26xdt
	gwvH/F4kGulRu2EPBQGI5Ct6OA6U2UaN23XcdPDUTx5Yk+AEZE/QVE7WDSGUGO8naOiFcUDYmC2
	CBe2OH5pc2wzcyA7lGB00+YRfrz5YEjdQ+AsipRVJcjfNltlbiv9lypnWwSwjkrKaeahkrp2IAz
	s1Os2BBb3su3jazfTrZ83XlSNVJAqyJ7BPeRfW85aMk/bwtmoh69CnKxt0joxWasR2pYA2osoQ2
	Dy9H1BtXuQKg43/jTmYrOHTDwIzJE7KwTltq0Xn4vtxEuAvmKqw/kMRJL17SOKeJS7YySqJlpih
	DSylMB7KdJ+DugP6E/dO4CaDhzjvkBvoNsZ6BYAH8IWrwQsNGdDSw==
X-Received: by 2002:ac8:6909:0:b0:50d:a8f5:1c03 with SMTP id d75a77b69052e-5165a0072f3mr49262241cf.4.1778847145586;
        Fri, 15 May 2026 05:12:25 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm45534491cf.3.2026.05.15.05.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:12:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] wifi: iwlwifi: mvm: include matches_len in scan-offload-query length check
Date: Fri, 15 May 2026 08:10:57 -0400
Message-ID: <20260515121100.649334-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515121100.649334-1-michael.bommarito@gmail.com>
References: <20260515121100.649334-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E139B54FB6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247733-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

iwl_mvm_netdetect_query_results() validates the firmware response
length against query_len (the fixed-header size of struct
iwl_scan_offload_match_info or iwl_scan_offload_profiles_query_v1)
but immediately follows with:

	memcpy(results->matches, query->matches, matches_len);

where matches_len is

	sizeof(struct iwl_scan_offload_profile_match[_v1]) *
		iwl_umac_scan_get_max_profiles(mvm->fw)

and is not included in the guard. A firmware response of exactly
query_len bytes therefore satisfies the guard yet the memcpy
reads matches_len bytes past the end of the slab-allocated
firmware-response buffer. The worst-case extent depends on the
firmware path:

  - v2 layout, SCAN_OFFLOAD_UPDATE_PROFILES_CMD version unknown
    or < 3: matches_len = 18 * IWL_SCAN_MAX_PROFILES = 198 bytes.
  - v2 layout, command version >= 3:
    matches_len = 18 * IWL_SCAN_MAX_PROFILES_V2 = 144 bytes.
  - v1 layout: matches_len = 16 * IWL_SCAN_MAX_PROFILES = 176 bytes.

Reproduced under UML+KASAN via a KUnit harness that lifts the
length-validation + memcpy logic into a self-contained test.
With the response sized at the v2 query_len (24 bytes of
match-info header) and the older-firmware max_profiles path,
KASAN reports a slab-out-of-bounds READ of 198 bytes at 0 bytes
to the right of a 24-byte allocation in the kmalloc-32 cache.
Building drivers/net/wireless/intel/iwlwifi/mvm/d3.o under
x86_64 allmodconfig with the fix applied yields no new warnings.

The sibling fix iwl_mvm_nd_match_info_handler() was corrected
by commit 744fabc338e8 ("wifi: iwlwifi: mvm: fix potential
out-of-bounds read in iwl_mvm_nd_match_info_handler()"). The
present function was missed during that audit; apply the same
correction shape.

Cc: stable@vger.kernel.org
Fixes: e4fe5d4b10cd ("iwlwifi: mvm: Support new format of SCAN_OFFLOAD_PROFILES_QUERY_RSP")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9a74f60c9185..c17ac62feec3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2458,7 +2458,7 @@ iwl_mvm_netdetect_query_results(struct iwl_mvm *mvm,
 	}
 
 	len = iwl_rx_packet_payload_len(cmd.resp_pkt);
-	if (len < query_len) {
+	if (len < query_len + matches_len) {
 		IWL_ERR(mvm, "Invalid scan offload profiles query response!\n");
 		ret = -EIO;
 		goto out_free_resp;
-- 
2.53.0


