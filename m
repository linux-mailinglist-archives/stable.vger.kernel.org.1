Return-Path: <stable+bounces-273296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qLCHG7AzUWrZAgMAu9opvQ
	(envelope-from <stable+bounces-273296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:02:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73473D2B3
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:02:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V46GW3xD;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273296-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273296-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9244A300C7CA
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667B376BFB;
	Fri, 10 Jul 2026 18:02:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BD261B71
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 18:02:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706527; cv=pass; b=BF5ANdIp5/HWLluOuyU7oBXqieV9KhPceAm1H5JcmyBQxrZz+Qo9tBjZn5ZxGxMQdxPZ+84L34XGTflN/EMbsV7dp/L0OnbKVo9AMmNP/35piWnk7BaRNCrWPggdHPlzSl0ALcw2vAGr5xNn2jbw0KqV7luZJtRy7A9V8jh8mzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706527; c=relaxed/simple;
	bh=BlimoX1CbriQcmrDmp1LB+hjsXlgxmYzLWDj/mXuzv4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=skcO00mfjSTC5I8rFoB9O5lbQ4vnkOqZbybtJqj8eFJogILBMZAvygaDXRpUYxfxq1pqzm+7TzM+qF84b3Wej9Wdb00NPMqEg0O4pS4brtrn43BVUsc5wara9gE1Oel4KPBFX1Gj70JvJtM3OnlUevA/0H0rxl3Zj2qJpcmHFSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V46GW3xD; arc=pass smtp.client-ip=209.85.217.42
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-736eea06c3eso419772137.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783706525; cv=none;
        d=google.com; s=arc-20260327;
        b=fVJaxNPUivdtqhmNY5r2KULjKZIJXDDxoV0VA6N19EA/0rAGc5DDsWSsuKTJW2rZ6f
         8k5C3RY+w45XMTaKdQMLESA2wA0zxlVJeMxO4iGDvuK0ezdLi8iHhElVTLEEjSbliGud
         ylnDN+QLTYvuXlLOOcm5X4V92xNzPHcDv97h/m9ZsxAHLhD5LLeKwpm50BOBkTVRCWBK
         4uxr9unyv/wNhs9gM6buVJFFxw+0bHiGrFxRqKPfuYv1Znnmi49DSC3wQeLL+DY2pVjY
         8IQ4ToRKgOPiPHmeUYrVcZhmfdF81bFbtVkBVKfo+N49pDuT77H/ROXM/SnZz+o8gs60
         bf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BlimoX1CbriQcmrDmp1LB+hjsXlgxmYzLWDj/mXuzv4=;
        fh=bmoJIeQXGp2rhX5KTAXYm68NwfTeaJjYfQgzd+1cC8s=;
        b=pwgsQ9F0Yp2xEKokM8c9rpaLxLESiH/88Nd38NbH2nBdulyZweZiits+ZpXKIs8x8s
         /70rhvSFQlW2Ge4d8/5UBKnEc+7C74OeGyWoBvWBF2wtE40QvS1zflM5ghjyyG1oWRlr
         /7oPUIMYvwi77Uy4tuVQ3da3HLZtlXunjGMA6dUnpmQfa3CeaeS61HTMXk9/AOD2kCh1
         3aU14JGxVeMoOw3LuOObF2AWsNseRCaaFcqimkLBNyr3DlXlSt4eKP2xqh5m7Bf0Omdp
         n+tM7l5uBXvt30sUUQjFScM/uTSZNTYYM4D0Hw00bILoY8sDvjNplTSSgOJCSkBlDEsQ
         /fXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706525; x=1784311325; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BlimoX1CbriQcmrDmp1LB+hjsXlgxmYzLWDj/mXuzv4=;
        b=V46GW3xDyuqCalswSaSs+FOepZBqwDTn5PS7oGv2+rGvp9VbepaultgHippZKbzWiM
         SxsNg4bHLzZ1ue2JBmnpBl8cGCT/iQ6K4Jln2bPLey4Oysfujj6XRxwIs1d8R0bhsBlx
         nsVnjkUeXCF74+jTGnyt+8cs68HRdwfOP1y0k6OvzGP7N2hk8HqHGwxFOt9wSYsVN/mY
         se0rzo1jiSG6uXKUYrp+Qndpen11+92KZL38xEyjivp+TtmZagFSVS3QpelugvEo5lhV
         1xP1xFILV42qOwS3GWiKSjUHvtfr4ZyRgSkgQ73EO9Kj3shmoICoSR856eQ1E+pAwIih
         UiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706525; x=1784311325;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BlimoX1CbriQcmrDmp1LB+hjsXlgxmYzLWDj/mXuzv4=;
        b=Kgvzmddwza8DwC/qHx+D/Isy7Lj575pFpjDhxPUlQdDHSOCmkLBs73+ZbOS+b4DAq6
         +1CoMCg6BCxpEXl0qneztf3xwDhTL/13Cv1a9dQdd/rWlBDJ59g7Pda/BYc1eUSD14h3
         SB7uQ+5sMT9s+TZUWQfcTdG9Wa52rra4xiO2dFp9XaG9i4xZ2vhV1isBu4zNsvH00zVq
         5sLrHdBR8CcJG9r0v9+hA0vJ0kjbyjI2tBsu8yzG9rFocUUBpRrEw0w5dzeT+AjnWZxX
         ZL0ONoCRmB7n8TFXi8DnR7ch97QdOak7HfwlYuC+Z+WWWeLuplCNm2XMdoRbjL25ibzK
         aCnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqE17SpgAh/Qo6+ZlvgBow2N0pNJkhEFSwig4RNbwPir39rybWg+7ijSpiJoEoil7mqhRIle0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwER70vo1/UXN1nIT/caXXEEj4OyQCfPtL++qFSeuFj4KwCN2WV
	Ilve+I2+ZAL4YySZUeXzQcPpsgCrFzrT6S4O3l60uJaEFfwDvlRJlgVeXnUsxogycDQ9mPvJGnb
	d6GpoAGrwvcMX45amrjkBKaeRhy/uRnY=
X-Gm-Gg: AfdE7ck6L9UaTaCd2NY9uQpBaiY/vxSBtIROQrZHSxJxfYMvuhphmlGx0WkUrjjnG8+
	byuBMi5EmI2CQS1Nc2MVeLKGKB/72tb++tbJbzZdjzSqnjYxi6uXT1M7v4Dms+vX02HiqrtHKf8
	bNMxqjaOecKkc/4AgmQ3EdYIbUsrt8YUPUdQdVNvhCp9nwzHl6htaZvjFkmpz9ZdCDe8OBZcLrs
	MY02TDvS5rWKMzwfe3Kl1TCGSoefBbvr39ChjrGbZPMHKKDr1Q3MxUgQGe/SIHNfOaOiuAPBhmm
	YsCTc+WMENpzRJl1dAjFozZCHys0iJv2m43nYWvir6/meM5/lETptmyxF/fXnwC9pJ4Y+h8IGhM
	Hv4z5FwSjLYVvR5wTVDll+BOpE1mYYa1r1Ak2ZoCGi01lFsLZ
X-Received: by 2002:a05:6102:6891:b0:738:d6c:7104 with SMTP id
 ada2fe7eead31-7453384d14amr296475137.0.1783706525271; Fri, 10 Jul 2026
 11:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Avraham Hollander <anhollander516@gmail.com>
Date: Fri, 10 Jul 2026 14:01:53 -0400
X-Gm-Features: AUfX_mwWzHxqlsdRXMKYl-ddla6vBJRXE6CpJ-JSoQ7f70O37_nQ9val2xs48eM
Message-ID: <CAP1mzZSp9A5w7ac0Qh-NAdtT+MoerWxYngfQYcm-bVF5yDWd1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ACPI: battery: Do not generate too much pressure
 on ACPI methods
To: i@rong.moe
Cc: jeffrey@waelti.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mpearson-lenovo@squebb.ca, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rickk1166@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,vger.kernel.org:server fail,mail.gmail.com:server fail];
	TAGGED_FROM(0.00)[bounces-273296-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[waelti.dev,kernel.org,vger.kernel.org,squebb.ca,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:i@rong.moe,m:jeffrey@waelti.dev,m:lenb@kernel.org,m:linux-acpi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mpearson-lenovo@squebb.ca,m:rafael.j.wysocki@intel.com,m:rafael@kernel.org,m:rickk1166@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anhollander516@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anhollander516@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D73473D2B3

Tested-by: Avraham Hollander <anhollander516@gmail.com>

