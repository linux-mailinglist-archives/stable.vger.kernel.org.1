Return-Path: <stable+bounces-212924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE0LJk1CfWnIRAIAu9opvQ
	(envelope-from <stable+bounces-212924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 00:44:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157DBF6CB
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 00:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3978830058F6
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 23:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE938B7C7;
	Fri, 30 Jan 2026 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+OHOeuH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219CA2D8370
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769816647; cv=none; b=DIl6XJAmlV58UPdsjoOtwnmitGF6UQx5SEuBZ7fE6+SCeNcCQA4bQeUj1J1zAqrjuBlOjPGye1aanWN3FmsfGYpk0wMYG3G/QvBB2iieoIlWLUmYsn6AlSkCWUslF4QOo+Xa+QLhyGvJ4pWYisWj/jsfSDbl0DkBk1Ds7twlgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769816647; c=relaxed/simple;
	bh=dR0F3EMGWh5ahhwUJyWJNhY/BpTFkjYYDkVdU3wHi/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Erd1mLDP2yODuILch8Th0g/YUU0Tztn1WPOZFWHvjiRyLvUltNrgFc1igE2/YVmxtjlRs58oIBSjw8X/3EFOqcIgo6mjthuOEc+7fpnQdTM+OyHCRBY7aSXaz3krimekoB9yXahwWVnBswwfzIOERabz2E8gkz6xOIaV6j/k/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+OHOeuH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so13618395e9.1
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 15:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769816644; x=1770421444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dR0F3EMGWh5ahhwUJyWJNhY/BpTFkjYYDkVdU3wHi/M=;
        b=Z+OHOeuHKTpZNJFvosort1CYjKRI6QKfId7jFJP9ypDY4qqalrTG2hu/Oo1LG7POKm
         pRbrChMuJkCljmiJTM9hJPVTq7sMMcncMmhN4gFpVeq0Q+IWhlQDqa8hiW0kLaLEWfyr
         vBLlqCHe/UBjfn/UWfTBkT0mRXRShTUKSNwo/emJJb3rqHnk5auXbw7Za6tnhEudNG7+
         npH893C2iDqX+2V0Sy+rmAWcTQZiF1zPSBfbrZ6RzUTfy/fyqekD141DMKJVA3K6xvHd
         PQ1RmQN2TaM2PUnEp5y6Gow/hHTR9cf0KtqAOalZHAdP406YXZrheS9eiFvGPHBPYsxs
         SNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769816644; x=1770421444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR0F3EMGWh5ahhwUJyWJNhY/BpTFkjYYDkVdU3wHi/M=;
        b=HhiKfg1DMXEGXsckiUjd/TYT4utkLRp2qhY++JaAarY3b9/WfEsb7Z/HPUpHz4O2Fv
         MTD2gf9h9eB6YD7lXc48DgDG+pyX67nRUO10IeXtaMYr04c2q0ZsjO1vNayGubmm2Yoq
         UPPaiOLdwnyUdgzBCc28FMrqDvSvOJz21qaeJ7lyp/1q8W9KFvQyiruNDYupilVGvpqS
         VP6Mvr1cRGbqRYRvmDf3YMor4iAgCEYbqIQlXwWNAlRMv5ZSHw2nQ7F2Q4yu2CUCHC46
         o8RnJB1Hs+ekfUq7CIfylWkV3cFwxzja1lHTJYO1ziVTQzbGbef34XcDZ0Hegmun3A2d
         vDRw==
X-Forwarded-Encrypted: i=1; AJvYcCVLliaRagky4VIOOtW7ORGP9vTEH+inPkJPyKsHdX0MQ9wxpUA3V6zVgy1+Songr4WT/C5mutc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwReM2T//jyVEFlUtMomUbYlY04S57D4Hz8Qm5Tc21A01ITypdh
	O6SUKioMi7cLbV7pYudEXM5l56Cfm2/RxPKN+zNiAvT1lgOTqRscKz2iDUJAZncQUHI=
X-Gm-Gg: AZuq6aJ9txmDNHmhDfSF/wRrSrJ8X148a2Cz/LrfhFig14OyJfJqeZEoIMwLMGWPruq
	3ctLX0XMgRn86rhiNxJFPStlqqWHdmM7PnpDRkPkLe32pO+E0aj8O7P7zvaJVaf+rWtvT+HsQ10
	8jzuOucf4nblLOky59NQSeL+HI37WkGGAgUSDoAhVtZgyHc28mS1hs6nePFdEWQUQVbeXjnlbok
	YjYNIhzpnj+QX/U/wLSRRmyMm7HrIlBUC6iemb9J3znMKY0QOqPw8oKXNTd7A3bzy9M4RG8E1bb
	rigKShK3KIMopztuny6lzNA+bxpV+58dENkrm2rj/ZxU2SGCZ2FNcS3cBdFxb7qyuv2qU02zROv
	/LEWsZeFMyRaszCpd07Yyv0d6KF9BcYXgKRQQ4NZD3qtvFamVG7mhfGz3DvVPyQbmUlSCxsx51q
	AFMVdorwbTcxm6ZjWUqe63UuI=
X-Received: by 2002:a05:600c:8b65:b0:47e:e61d:b8d2 with SMTP id 5b1f17b1804b1-482db486ee9mr55984625e9.27.1769816644353;
        Fri, 30 Jan 2026 15:44:04 -0800 (PST)
Received: from debian.local ([2a0a:ef40:e94:5d01:a218:5589:9f9c:4f52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd77b8sm229200855e9.3.2026.01.30.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 15:44:03 -0800 (PST)
Date: Fri, 30 Jan 2026 23:44:01 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Message-ID: <aX1CQb1P7QA1JefK@debian.local>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local>
 <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
 <DM3PPF63A6024A9FCE1CF29C0492A406E7AA390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXit5795WQLL290t@debian.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXit5795WQLL290t@debian.local>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212924-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[debian.local:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3157DBF6CB
X-Rspamd-Action: no action

Hi,

I've been running a kernel with both of the suspend fixes (pause TCM on
fast resume, cleanup IWL_MVM_STATUS_IN_HW_RESTART in resume) here for
the last few days. I just experienced this fault - not from
suspend/resume this time though, the laptop wasn't doing anything
particular at the time, so no idea how to reproduce it.
Maybe it's related though (?) as it has the same
"Error sending SYSTEM_STATISTICS_CMD: time out after 2000ms."
It recovered ok, wifi was functional afterwards.

[37410.975565] iwlwifi 0000:01:00.0: Error sending SYSTEM_STATISTICS_CMD: time out after 2000ms.
[37410.975741] iwlwifi 0000:01:00.0: Current CMD queue read_ptr 39088 write_ptr 39089
[37410.977474] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[37410.977480] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[37410.977486] iwlwifi 0000:01:00.0: Loaded firmware version: 89.7f71c7f4.0 ty-a0-gf-a0-89.ucode
[37410.977491] iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
[37410.977497] iwlwifi 0000:01:00.0: 0x00008210 | trm_hw_status0
[37410.977502] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[37410.977506] iwlwifi 0000:01:00.0: 0x004DAD04 | branchlink2
[37410.977511] iwlwifi 0000:01:00.0: 0x004D092A | interruptlink1
[37410.977515] iwlwifi 0000:01:00.0: 0x004D092A | interruptlink2
[37410.977520] iwlwifi 0000:01:00.0: 0x00016AD2 | data1
[37410.977524] iwlwifi 0000:01:00.0: 0x01000000 | data2
[37410.977529] iwlwifi 0000:01:00.0: 0x00000000 | data3
[37410.977533] iwlwifi 0000:01:00.0: 0x70C01827 | beacon time
[37410.977538] iwlwifi 0000:01:00.0: 0xAD47B7F5 | tsf low
[37410.977542] iwlwifi 0000:01:00.0: 0x0000066B | tsf hi
[37410.977547] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[37410.977551] iwlwifi 0000:01:00.0: 0xB3FD3A22 | time gp2
[37410.977555] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[37410.977560] iwlwifi 0000:01:00.0: 0x00000059 | uCode version major
[37410.977565] iwlwifi 0000:01:00.0: 0x7F71C7F4 | uCode version minor
[37410.977569] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[37410.977574] iwlwifi 0000:01:00.0: 0x00C80002 | board version
[37410.977578] iwlwifi 0000:01:00.0: 0x80F3FD26 | hcmd
[37410.977583] iwlwifi 0000:01:00.0: 0x24020000 | isr0
[37410.977587] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[37410.977591] iwlwifi 0000:01:00.0: 0x40F84002 | isr2
[37410.977596] iwlwifi 0000:01:00.0: 0x04C3081C | isr3
[37410.977600] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[37410.977604] iwlwifi 0000:01:00.0: 0x0326001C | last cmd Id
[37410.977609] iwlwifi 0000:01:00.0: 0x00016AD2 | wait_event
[37410.977613] iwlwifi 0000:01:00.0: 0x00000080 | l2p_control
[37410.977618] iwlwifi 0000:01:00.0: 0x00010014 | l2p_duration
[37410.977622] iwlwifi 0000:01:00.0: 0x0000003F | l2p_mhvalid
[37410.977627] iwlwifi 0000:01:00.0: 0x00001800 | l2p_addr_match
[37410.977631] iwlwifi 0000:01:00.0: 0x00000008 | lmpm_pmg_sel
[37410.977635] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[37410.977640] iwlwifi 0000:01:00.0: 0x06647878 | flow_handler
[37410.977678] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[37410.977682] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[37410.977687] iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
[37410.977692] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[37410.977697] iwlwifi 0000:01:00.0: 0x804838BE | umac branchlink2
[37410.977701] iwlwifi 0000:01:00.0: 0x804A5D36 | umac interruptlink1
[37410.977706] iwlwifi 0000:01:00.0: 0x804A5D36 | umac interruptlink2
[37410.977710] iwlwifi 0000:01:00.0: 0x01000000 | umac data1
[37410.977715] iwlwifi 0000:01:00.0: 0x804A5D36 | umac data2
[37410.977719] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
[37410.977723] iwlwifi 0000:01:00.0: 0x00000059 | umac major
[37410.977728] iwlwifi 0000:01:00.0: 0x7F71C7F4 | umac minor
[37410.977732] iwlwifi 0000:01:00.0: 0xB3FD3A20 | frame pointer
[37410.977736] iwlwifi 0000:01:00.0: 0xC0886258 | stack pointer
[37410.977741] iwlwifi 0000:01:00.0: 0x00B0020F | last host cmd
[37410.977745] iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
[37410.977759] iwlwifi 0000:01:00.0: IML/ROM dump:
[37410.977764] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[37410.977778] iwlwifi 0000:01:00.0: 0x00008EBB | IML/ROM data1
[37410.977792] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[37410.977802] iwlwifi 0000:01:00.0: Fseq Registers:
[37410.977868] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[37410.977875] iwlwifi 0000:01:00.0: 0x80440007 | FSEQ_TOP_INIT_VERSION
[37410.977882] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[37410.977889] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[37410.977896] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[37410.977902] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[37410.977909] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[37410.977915] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[37410.977922] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[37410.977930] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[37410.977939] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[37410.977948] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[37410.977954] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERSION
[37410.977961] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[37410.977968] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[37410.977974] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[37410.977988] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0x804a57fc
[37410.977995] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[37410.978994] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[37411.452630] iwlwifi 0000:01:00.0: Device error - SW reset
[37411.452783] ieee80211 phy0: Hardware restart was requested
[37411.699230] iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[37411.699393] iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[37411.699479] iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
[37411.699553] iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[37411.837813] iwlwifi 0000:01:00.0: restart completed

