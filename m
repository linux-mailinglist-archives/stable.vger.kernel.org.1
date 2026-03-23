Return-Path: <stable+bounces-227964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKnCA7E0wWm7RQQAu9opvQ
	(envelope-from <stable+bounces-227964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:40:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8012B2F20CF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2755E30BED72
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3463A5439;
	Mon, 23 Mar 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM/i673w"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B633A5451
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269095; cv=none; b=mM/zM7YymQ0A81xdi8VPZDBVV8/vLoFe/YY8UrkHM3v1XuRun02JSSXFEVXb8WQDprPB1DZGuOM6Pbs31waKX+qL4oc7A/ihdR71wZlNECaoWuXHS3gXEgbjUSVw7M/4rEjf3SsCbCljg7XyZnop/Ylc6QwTSy3iDaUI8A454yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269095; c=relaxed/simple;
	bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=uFzf8T5DinAIYdxyG96JMlRvlaCsyLkRbHXnng8aSvvIeJzLRuy+QHyLaSybuVkeFX3D0uHWzPnDm0W5B5PTclgHCdtq9c2dNwrHrExqIR+5+n1mJKU9gsLua1IahZ0w/f38tS18zN0fpJsuX2fXTplyg745m8EWkpFYGUOk6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM/i673w; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a27a7f711eso39202e87.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269088; x=1774873888; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
        b=PM/i673wZXZ47wS1CGpjC2G8sC1XiH1kd62IqDiKkg/0Tt5yCpVMRFYx5h8PHG8cfV
         20GHIW3OIUG6ISaY0jzjkJRw5KNdIckM2QpHyQ98YKt5CcpFIPBQx27pKBHIVUfxV6Wu
         Rj0yr0oJjwD7G2O1PhWVM5v1vyCfwrk7PeSxrimwz0Ss58q6mpljojLJJMSx4OrMXNFf
         ezIAiZ/goYAsgoUqJfNppXzRjdlpiJn0q0JIAFwiNGfdu9VWB2OsLHln3EMsEBqmRqV8
         EgbzFEUr4KTqOl7q+ck99yrDBcrRBtsdEdTMQBx1C0NOKzrgRq9hmRrzj/VdunRHAIYR
         tOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269088; x=1774873888;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
        b=G9jRzCabtX6YFIxBYCddJH8TSg5sV8/jDHjMm0L09PLUMe022iH7XR4zaG1Skzl6c/
         nHhcp80Rte3WvHQ4XX3ikfPYC+JD7wIAm3oW0MTNzbX74VVEba0i9CsV1705sI9YeKYj
         /bZXqcUFO9+1d7LqnQkc2g6V/sSWl65F8tveHeZ4FfbKMC2zBoOOvQNslyyFUvLzv52x
         euWnW9U/V7Ti/qQ1eOEEcsuLzOsOVXQvEuFuROK4NfZVz0dtA/2XoBeCPC6hnM2Us0Q7
         xY9hAI9FoGovCxpYOzKABDse+kZ7ZB24L+ynS+/PmDu4zx/uT0EZgMXoKZzZxQTnyrEC
         U0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXufPikhhH8pQHtYZooMDKUsEcTOhmuFyKYhnl52VrJn2M9mXmUTEoMsNacak4oEiEyiOqBthY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Wuvp0MjBhI8hJc/y7j2VLxFzs6+3i5aPGTMJ1YFC6UfZFAJy
	gq/DAxK5NGoJYWCgjJE5erMgxTe9/y3Yl9GOEUwPnJgN44ABEhyaIkA=
X-Gm-Gg: ATEYQzwEKYTfOLBfNzYnxkzwj6yJtW4VgqdOzsgOWO7hnzMFzHSXU5WX6coZA+XUNUm
	NBcBGqczHUiDeYHXKOtarmn2T/UaggF8lvCZ49jNXEqizKZg2PuiTfeU0TTqmK8FYJIHw1V2J3c
	vpR/RQynIz6woRrVWE2VPB2Pr+yaUMGRn0nUk99Y+1wrAqWGtBnFwJ4a5yBmrY0oAjuIICbNhPy
	wsRbXknLbnPmzP4iln20i8I65S/rixkCjFH483eofm6YP2Hb6/LdkQyM/jbxUvBtjoWe7/5+wLN
	77B0wFQ2BNJMr8GX/kKKQG4pjzr9/cvqrEcQgtJnDCnfxB1tpz38YY+ZgCK3vYWElVyygcfLia8
	0zl/QkyCNjPHkIIOaCZWcHt+57cwW2YYqHCcZ1UWqIj9SRpEu3f/t9JJvdadduJ11foAHWCbaI2
	9O8t8Ec4kWCpw2lePKPe43ycmeU+a9t+xlOhyXEnxz6byIA0z+DLKCkSMMHCj2uvUeOmqwKVyCe
	6PuAMbOFrL1Lm40z+Fceb6CGO0vIyRCpU96RP4YI7Vi
X-Received: by 2002:a05:6512:acf:b0:5a2:799b:4055 with SMTP id 2adb3069b0e04-5a285b92854mr3712410e87.39.1774269088110;
        Mon, 23 Mar 2026 05:31:28 -0700 (PDT)
Received: from bf-laptop.int.bjornfor.name ([84.215.3.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28530cb91sm2582086e87.77.2026.03.23.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:31:27 -0700 (PDT)
Message-ID: <457c6760c569134a637d43d38e86d405963487d9.camel@gmail.com>
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU
 for OF platforms"
From: bjorn.forsman@gmail.com
To: john@kernel.doghat.io
Cc: bhelgaas@google.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-pci@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com, 
	stable@vger.kernel.org
Date: Mon, 23 Mar 2026 13:31:25 +0100
In-Reply-To: <20260320172335.29778-1-john@kernel.doghat.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[bjornforsman@gmail.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227964-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8012B2F20CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Thanks for submitting this fix/revert -- I spent a lot of time today
figuring out why my VM didn't start anymore, and finally came here.

Seeing that it's been a few days since this was posted, I figured I'd
add this message as a "ping" to the committers, in hopes of getting
this merged soon. (This regression is hitting end users now.)

Best regards,
Bj=C3=B8rn Forsman

