Return-Path: <stable+bounces-223447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGQVId5ErWlp0gEAu9opvQ
	(envelope-from <stable+bounces-223447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 10:43:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB0822F3BA
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 10:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3ED49300609A
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30C336ED1;
	Sun,  8 Mar 2026 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1Vk7ONZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443B50276
	for <stable@vger.kernel.org>; Sun,  8 Mar 2026 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772963030; cv=pass; b=Dqw5eHszdrvUtHTS8hLFpS6IoV6IYN7RSkJZUYIlxJPSzrJQJjomruaT4Y8xOQmFAeOj0p5AoANyXc109QuOwA5OODqDSbB8A8UbLX7ZEwzMFat9dwi/Z5dEDjYj5HEE8v7r7enTFD0t2MxN1beR5jk9316tP5raa5JqVMr4UaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772963030; c=relaxed/simple;
	bh=QZ3zs9sgVddDi793qqx9GCkihBskMqNr2xNe/QJf9C0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bCpkd09RXERgxMKv/mggRMarAFavrbqwhVg0u24xQegJQ8ogxC8Od8DFsxGEB/GPyAabwhNJHO/deZvkCjxuACubua8vJ3eisdMwj8jb1Hj76YM9AbJ3I6VqWVjQ2bp/AqMpSZBzoeWw1SNM5wdOs8a4nZrBEtCtmFh4cn+n81s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1Vk7ONZ; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79868cde1eeso116744607b3.2
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 01:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772963028; cv=none;
        d=google.com; s=arc-20240605;
        b=lLX+aGMrejv25beqwgrv1PpR4lrO9cbRHwvu0SuSjVzUe9XLUW50Cnxi52vzxS29Al
         quuFCEicbr0YtfbuB4CjoFYhhr0376AJtfh/Rgm3hz0iPdAkirrASE+ciZbsP4QSmTHG
         I841TouposC2mZSGECdL6M0pOMCmL0C4SuVpGarxNhXEulTdMDrA62FreUjDeCKJa63s
         tkb+VISBQVGAX27uxtWHTTStBkTOdzDx5u/pA2pVgpJ9tH1RkjmuEn5HwNejlwlAAFe3
         idRMXREbOHBzevKxF6Ei7qqc2rkW4+tGkdFtfaifuBGnWMjaadJs6FSlVzIp+aqjZkPZ
         mvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zktwThrJdWq3kBHVGGUBRgfeie90jX4lYf1F8zPH1CY=;
        fh=VMSZDy67JbtICA61VAUG8CamZaF/KLvDFjqY8hSo1lw=;
        b=F155pd2NIbPx3hVC94XbG61LVxint4C6RFIsbOLDddTrhnPa6KXevM5YHY7DK4X3tg
         rLEQg5mgnQ5p04M3C63/8rBABfJd0B9Ydy3NBWhoSusyTAhW2HCAJsRA8qKgvctDlJRf
         5d87/R0GkmzSI2ygtlqoLV/ti96KVVCpzR5nQtVeZxOg/DH5Frfmc1hvVQwOU8NzwwCy
         zE5DscQ9VLsf0AUh0JBtOj9jdXzLuKTJ1L4JfNr5oZCVdtzFYvgBLnW4xHsXCj1fv1pQ
         2/1+Zpgb6hO4ShUOE7YxiLUOP65mCPJFz22D860wEYVD7Kqrp1YzR9T9e3Ah/NTl/92q
         abEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772963028; x=1773567828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zktwThrJdWq3kBHVGGUBRgfeie90jX4lYf1F8zPH1CY=;
        b=J1Vk7ONZTW2miaagNSWun4gKMPB6Ggd3eQS5zlQb0COfV3MRtDB4RnNPFafxze67dg
         EN8NDKhOMPl3msWNPMn7v4wXwggGcLqHFDmlCUWWYZP3HjW19IrUARZZdJc8nPyMNBHX
         +Y4Co7u2nFSl93gpf3kDbfMhVSw/0JZR+XmNCf53ZsmtMNP9CPxhD+TyM7M6gEQZ5hn8
         aYE3DeAHiMKzXS8AJKpj6KMLTGKtrWaEpLvJuHUCYYRPKM1ftMDL7IcSRjjXfxGv6fEX
         nw71azwx00OPVcR7/mWdTdyFSx6YX3NWwVrlCCk7PIjh3/JqvrKWjkTzl+ELJSN0QYWz
         6p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772963028; x=1773567828;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zktwThrJdWq3kBHVGGUBRgfeie90jX4lYf1F8zPH1CY=;
        b=VfEiMtcaW9JoAGMgzOmxiu/bOEesPUXlWQvOXlh8mtN97OV5KKaqAPZ/lZTWECuvML
         WoBsl8QJ/lokrSQaaqSb3iiBSROTT3uxJ96U2qvDueD4FXCCR9HwU/Qx1jryHqHAaVSt
         qAskAhWgQr9cYJgXb+nhHx+vWIRI0SxoOdCOjHUGNbn15CS2dsyTBJ+3XSzkp6eNTGSQ
         4BnTV9h4c7o+fEKxnxSdBOioMdmbwEzGxJrhz7B2c7WZbTAZLV4T5zI4fQGz8WTwcE84
         4C9fhvfGaXv3EAcl4IuXcTDdzGlZTX+ozFy0Xace3JDhrtZeFk8y7sCMO392qdj56x0/
         o16g==
X-Gm-Message-State: AOJu0Yzb34uB7a8HzLMNVUBXrqYvWTIO0QMTeTAq04DCMWs0G+yUvMvR
	7Eyk8KMFp/q/GEqHKZlH+DcuHsR8CcxJMP/sZ1QwChDEaNTqIEuac/Ps9Fx50NECmHbFDx/2N8Y
	lf+50wVMlg5FvbfUelatmlbf5Iu21b2bn+6lioHKLyw==
X-Gm-Gg: ATEYQzwgUdp1gqz4yF/sg2eKYP2HpVbgSsnyCexTwuAUTpHoM0NjNBKg4ZwXb6dx2ix
	LT8ZTuYbqEcrE2EVdWEIHD/2XXy2zwz7Kas+wMAmJpnugXW/qsOkW/CW+fJ3cusKj84XdydlwqN
	YZMEKieoFHuPUV2K2zn/FSX1GFfF1CxW152jTDLYJ49la7VOhqr4mgHoCOKraSiZ9w8tCPd0pTN
	NxLSCNZSzg4xMlfhhCdnK0dARx6fOU5+9fPa2XVfKUK2GvY+3sL4xIMFPlWdiEcjb/Rl+7f4QZk
	H5XbyWih
X-Received: by 2002:a05:690c:498f:b0:796:3981:fd6e with SMTP id
 00721157ae682-798dd678955mr72002307b3.10.1772963028584; Sun, 08 Mar 2026
 01:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: hgfdgjn <shichuanyim@gmail.com>
Date: Sun, 8 Mar 2026 17:42:39 +0800
X-Gm-Features: AaiRm53utfIeCUEKgMYi5TWq9-UKPrGZ-oYJqtHpIraEicoLZaovu6NI_AwZsTE
Message-ID: <CA+tjKGrmADg=oG9CT74_mgGNN3h17=LLmnv51K=MggAqo7q2Eg@mail.gmail.com>
Subject: [BUG] HDMI monitor shows no signal when the refresh rate is higher
 than the default 60Hz
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8AB0822F3BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223447-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shichuanyim@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.913];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi maintainers:

  After updating to v6.19.6 on Arch Linux, if I set the refresh rate
higher than 60Hz, the monitor displays "No Signal".
I tried bisecting and found:
> # first bad commit: [3471b9a31ce352ffb343cf02a991261880aac3a7] drm/amd/display: Rework HDMI data channel reads

This issue on my machine was caused by this change:

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 267180e7bc48..5d2bcce2f669 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -549,7 +549,8 @@ void write_scdc_data(struct ddc_service *ddc_service,
     /*Lower than 340 Scramble bit from SCDC caps*/

     if (ddc_service->link->local_sink &&
-        ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite)
+        (ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite
||
+        !ddc_service->link->local_sink->edid_caps.scdc_present))
         return;

     link_query_ddc_data(ddc_service, slave_address, &offset,


It appears that scdc_present is always false on my device.
I reverted the change to write_scdc_data(), and the monitor works
normally at high refresh rates.

