Return-Path: <stable+bounces-238094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACRkGD5r32niSgAAu9opvQ
	(envelope-from <stable+bounces-238094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:41:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2894035A5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDBE30038F2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1F346FAB;
	Wed, 15 Apr 2026 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCp31tco"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0F347535
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249556; cv=pass; b=aAEcWc0ZvOD66xUO4KxI3FB1TuZ6zOQrfhmZoh1eCLTNY9p/BaAG/yyBkKr1z17kRHqAllDK6GzJG2fyHlJhk2AG+tWD0wiZV+2A3zOO19e0oxEboHsGkO221L1brMML6MZ8M9Yr6RTaAf744e2omNyPzxuUuVK3m4CGaXCF8Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249556; c=relaxed/simple;
	bh=GfVO3mataKPZTl+zZ7bVK67m7nflCt2vlvwElWHXQpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rv09uQiznlDK3xcX4gm/BXM/vUcuITByz2G4GBWozTdXucl/pH0zE/SjQflSEkY4QnWkFwXUGmvirdCfsgii89NIeYacw1pRd4S9ncZi4esTvzwF2PZCf6iS48n/AwjqkUgallaBP9aTi+otXiMn2EjTUH7JVtHVtIbbQDvF95M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCp31tco; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501725d888so5143104d50.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776249554; cv=none;
        d=google.com; s=arc-20240605;
        b=U0o2q3Dsq2Quh1zRMcGED/n/6UjarCyEHHIWiugSwJYR/xOAoj/3TiZ27Lt1wOmECE
         4yHboPAHRH2S8sClF31JLQKiCKRXqpvzEfGbKnG0VJkCosCr2gp+NO7jJM4l8fNOja4C
         keLsnBCoiLy5ZQAZXC0meTLhs7Ea5COWivZj3Bh+2TWm0GWDfXkrIzcJka03cndldmLZ
         TAdO27GnBJSNNYT4Ce4d3G+sxGl0pE1te5GuUygFpxrqnCXsMFRExe4SCBbveLFWBikS
         FMr7Wbg0SyLCl8zRTc0wFRUqgKqiFH10oy5rY9PvLG4QVwM83L+LDVUE0tHGYHBVKj34
         tcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GfVO3mataKPZTl+zZ7bVK67m7nflCt2vlvwElWHXQpg=;
        fh=KMu15tK6NN4eIZX0V8SwyylMchuhro0+/PX/+peE17k=;
        b=EZpyjOXl8z87+BjtJh8y5fV2NMRys98ozJSUxEOCHGVSOkwtYKkXKD2GMdpV2UQyaG
         3GlS4SmGYVBZgZp/ArKZrKsbnAHpe418bVftvsibwQLZFCecEjFF7vsqsW6iU7Gw/+8V
         WcpKv+lj5Pe3PWeYpS9Qk/ZvkrKbJHdIC4HX8+DuXbQMsHMMjNQG88GtTtVBSbQqaTR8
         zR3/AA9Zsuchh9u7xapqsIWw2mQFSLIT3Cd9GSYXMJ+gFuwjF6MT6O2XjmXgruov+zOb
         SsPQdDIkB4HC2KbvzBMQoRfSB+6oiLCt8BOIUUhmnTGBohFrDd3nh0zIwfRNXJX8bsw2
         v1IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776249554; x=1776854354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfVO3mataKPZTl+zZ7bVK67m7nflCt2vlvwElWHXQpg=;
        b=YCp31tcoUVmzhl9YqICwsGwaGfHqEmUir2loCZa1WeE7GzlkfkCSvhyaSmUbRZoO27
         5ibdU0+6ynAQme0YNoJxGE7LEvHhYPRYlIK+qEko/Wg1Pb0OwVN0l4Ngdc82Cy93v5ML
         4IsDf6BhXiA2i+hiUE+XYqlZ0W51mu6f9gFEuZHUfsafR253OYkJgKJ3Q/9we95AlCAE
         YmSYRPe5To2HNHO77s+bNnpfwNJRylw3w+7BsQpFhT4LziB9dYFIDTaPrKU4W6n2Y6nU
         7B4VFejWuZP2J4+pI200WEZsJ1VYJx72EizROuEw47SwxirDQs/VXoyfK3Vloy70KRsv
         i7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249554; x=1776854354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfVO3mataKPZTl+zZ7bVK67m7nflCt2vlvwElWHXQpg=;
        b=dXCo1pk+H/DYgdIh+pYtZaYVSTEe5ejySU4Ll57ZmoWLzQkZIqWeHVQ46Cwm81mmoC
         Yf2OwJZdUou41thadaNemCDZRK5CRXdu3rP8/F7T7TpwMgA1XpbfglBtx7DofZ52/39b
         PIdB21L8l507Gbj9K44W++vq+bhSakl1+FD01IwvsAD8pV8Ijdm9oZRZWOgqVfPEjXTF
         mYRx0EzHsHW97CTUnRy/jwkjG9DC2KndgMcHAmFLto46ePMWTn8DSjwOgh38NYANM7YC
         1YDrDm3zm9HGL+fpmi3LPE95Y1w36tv3Y0pVI5aS6fT1HomSuNZLbYSxcu5m1OFR289d
         tshg==
X-Forwarded-Encrypted: i=1; AFNElJ8PAidl9OPR6VB46f70G3efAl4GzosNOpL30ozOCNhdPYxOrcfpinwuhXMmfAFdU54tE6vZQG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+A7EBNaov9gKbBWzKklpknT1kx6kH27+4dgN2detqFrUGvNtN
	09+YcyWJCfNx3Vo5oWgrX5YvP4YEU4N/g5VRkM8Hk5QgXBUXmLTYBcMYATYxRlPpfJ0Doa7wmB2
	NmgtBd9uqTb2yDsmtepgA3V1UQ7cgngQ=
X-Gm-Gg: AeBDievNbNL9oeQVeCd4P5wgETvZkq1H6SOY184cypFEg9bkc9bS65VX4ktr/tkSdHb
	5V0TVYyFPaRixwYRkS2Q70RBBz18hy2kFFG++9TU4k5gzx+k1GwEhxlH9dCBlCmghzfMAo4N2sw
	Ri7ZlezKD/2wojAjuSbXO2z68ESfB9fYIMYvLdzz3tTtCkCJJsFdjVVRsVdm30bhwtyb6isDnNl
	geIHGaTaFbyVR7Lvx5C5teU0gO9C05pvytXTHEYWieCRACtC/llhFhOUdEXERhfUfEMoFT2sjA6
	b0MYp6T1mV2C89TyGS8Gn7N1FL9eioI=
X-Received: by 2002:a05:690e:1404:b0:651:d2ff:dc6c with SMTP id
 956f58d0204a3-651d2ffef9amr9116210d50.68.1776249554088; Wed, 15 Apr 2026
 03:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413134345.2855417-1-lgs201920130244@gmail.com> <4yzeebhaojygexo2ori5xpwyjpldag66vkoywnnrcs2ncjoght@bjiaqfz6koeo>
In-Reply-To: <4yzeebhaojygexo2ori5xpwyjpldag66vkoywnnrcs2ncjoght@bjiaqfz6koeo>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 18:39:00 +0800
X-Gm-Features: AQROBzCMM7yF1lbVtFjb7fumcuxkzR_jd819BKirInIUv9EulL0NA_j9prMl11s
Message-ID: <CANUHTR9HNmNTnxKtWLQZV9rF4w=po4Uy_=iRxwEWuHq+JgGETw@mail.gmail.com>
Subject: Re: [PATCH v2] bus: fsl-mc: Fix refcount leak in fsl_mc_device_add()
 error path
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Stuart Yoder <stuart.yoder@freescale.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Graf <agraf@suse.de>, 
	"J. German Rivera" <German.Rivera@freescale.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238094-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: EF2894035A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ioana,

Thanks for reviewing.

On Wed, 15 Apr 2026 at 17:38, Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> What tree are you using?
>
> Ioana

I was using v6.19-rc8-214-ge7aa57247700 when I found this issue.

From the commit you pointed out, it seems the problem has already been
fixed upstream. Sorry for the duplicate report, and thanks again for
catching this.

Best regards,
Guangshuo

