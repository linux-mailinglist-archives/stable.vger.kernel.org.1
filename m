Return-Path: <stable+bounces-213005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGO8KWiQf2njtgIAu9opvQ
	(envelope-from <stable+bounces-213005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 18:42:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0890C6C49
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D82E3005D18
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45905274FDB;
	Sun,  1 Feb 2026 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="jHSv8CQG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3371E1DF0
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967713; cv=none; b=RvBM1Wm5wIs6Nb9vsXhVBBwT08+EQTsyOaYkEwHHlzX4ug21S7fA2fIRc/Q6Oub6J0QqaxgJMAgWFjCFGRBkRJAwsY1O0CmugRYyVs9IjKlqBILQeieCxsLIJbtGRw6p20zT83sGWBaVIlmBOo0QqqRmUQ094E+2wvt4dW0CQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967713; c=relaxed/simple;
	bh=Z2xWZTP7yYyZ8vjYmOZSCjzsryy3Jprv9gx9FDarUhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCo9DgQgOQ3OJtkx4q5/6OUTQus0QEkIrRfXCfVyQKsBupS8wOQh29Fbco5QN9WHZzZWdgx1pFXDq6XUK5gJpKVl8+6vSZVrEW+KmBjFzlZDn9JYAfqmoAGXY+Zn5b2JThp0r9dEGlTGX8HKdWntNI6MlmJZ57soGb/QUEZflnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=jHSv8CQG; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b71515d8adso3665828eec.1
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 09:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1769967710; x=1770572510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOV12rWpqihzHlDSFZMOhY48oPOESyDjFwOMFN7I8pY=;
        b=jHSv8CQGrEX9Ja3BhNH/Mxa4f283GnjQg0ALFjmditNLSgUcH0fubFmtVW/ymbO16S
         BMyD1OGXTV4OV4bWfEM8WA2Xz9zU26imDTNCc5AbVeYnkLrrQaeWK8G+XS3SBzMDCxqK
         +cftiPSAXV0HnvWCTXBhWANu+jJUSC6UHNQhXPILqYqun2xqx1oG/h6gdsK4N5LqFymU
         MbDycLAAxMhKLnp8zh0qFZKT1XopRAw4fXmC9sh8LTqeFPpNsKFQ6hG6InmutCtBzHQU
         KYD3Y7h6HB4GIY6IG13vSumZsCdFrGgpfszKMDlJ4ix4/kIy3fnPzFpZ06MOlvfHH/CU
         L+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967710; x=1770572510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOV12rWpqihzHlDSFZMOhY48oPOESyDjFwOMFN7I8pY=;
        b=MbLZnhfmJjXiub0rjUPB0rdcNiUZtspTwGvExgC0xysFG7Mnik/mzD6C1aymfF34b1
         N55tIOshDExEadsm4NOzZUUfVNcBL/HN2y7Jo/MDCuZ59Ro3pbeVZhOdUry/fXSNbKRd
         eyoHGNru38Lq+MA3KMEg9WQT8/8psbR2TpwRCNWCVIwaOQIzUFeHCyhkOY00wsB6av9i
         3CsdGlMvt6Q6oqm0I73KeTf9yLyfWQavq59Bw99rQp850vJM3S9kJcAl159ym4Gqt9wk
         tZzXRlLx5ykJxb6kOHHhLo7O9aM2M/UjRyyxN7RcwEnj4vifKy4WXuZth8sKVBNL0vk4
         Z9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIdwteh8k6YYvxa76EOiPwy6pI2NihDg4JPiTIziPacrnrEajD/QpXuaeFyMOduMdm98EJCYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYylh4oJqrBz1VcfwxCkrQygDLeCivAYj2KZUvp+m0t8t76pC+
	AFf8gZX2Nq34QF4tETxK0PyepTaoUnzOWkr+1FXaDGbrnfmVhFtHoNF5kr7JeeBx0g==
X-Gm-Gg: AZuq6aLtwKqSUmch3BoqfyTzv58+t9xqyuUFVj5DUeFj9oKvaBEMYxMJFK0U54fMqv3
	P+oEpMowG8h2KHOsFwLGwPhgqvML9jBdQusYx4mKq6+T/JIMokhisyTTgxhE6xYtPbdg36booKM
	1+v3bhAFRIZvq2JKR92reti8AcM+YVoi++9QGAaRKt/iuR+ap9jrs6zF78e7Yh+ibd6WYGKLntl
	f756/FkjxSDJnI39YTuTKCxLpT/Ic7Fgcii7k2JEiJTeSPYiWxjN8xzbTw6Quh85rqKEy7Iq8a0
	MxYMoqXYDfw45PMx7sDIbEg6zIld0Jq8eunWa+ixPkuTzZ5VeB+jQ99btDE1irGheNeLNLx5F0Y
	/3KZdEWNVuO2RCrPkB+bndnNAvQn+BJKtQFsLLjj7PvFl1yQrZGdAYdfAH7aw6Ux9KXGj5kTmoH
	gB3KhI26Flujet1joA8d1RTcrR3JM=
X-Received: by 2002:a05:7300:7306:b0:2b7:2fff:ed1f with SMTP id 5a478bee46e88-2b7c86657admr4535532eec.17.1769967710524;
        Sun, 01 Feb 2026 09:41:50 -0800 (PST)
Received: from gmail.com (129-219-8-213.nat.asu.edu. [129.219.8.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfa53sm18701642eec.1.2026.02.01.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:41:49 -0800 (PST)
Date: Sun, 1 Feb 2026 10:41:47 -0700
From: Will Rosenberg <whrosenb@asu.edu>
To: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oliver Rosenberg <olrose55@gmail.com>,
	=?utf-8?B?5p2c5LmJ5oGS?= <duyiheng@tju.edu.cn>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix NULL pointer dereference in
 __kernfs_new_node()
Message-ID: <aX+QW0yMZwVL5Y4h@gmail.com>
References: <AOoAIQD0J-9V1NW0JM55A4po.1.1769761572059.Hmail.3019244382@tju.edu.cn>
 <f5fe5674adee792e663a86d680d836c5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5fe5674adee792e663a86d680d836c5@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,tju.edu.cn,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_FROM(0.00)[bounces-213005-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[whrosenb@asu.edu,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: C0890C6C49
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 07:05:50AM -1000, Tejun Heo wrote:
> Commit 382b1e8f30f7 ("kernfs: fix memory leak of kernfs_iattrs in
> __kernfs_new_node") introduced an err_out4 error path which frees iattr
> when security_kernfs_init_security() fails. However, iattr is only
> allocated by __kernfs_setattr() when the node has non-default uid/gid.
> If the node uses default ownership, iattr remains NULL, and
> security_kernfs_init_security() failure would cause a NULL pointer
> dereference when err_out4 tries to access kn->iattr->xattrs.
> 
> Add a NULL check before freeing iattr.
> 
> Fixes: 382b1e8f30f7 ("kernfs: fix memory leak of kernfs_iattrs in __kernfs_new_node")

Thank you for reporting the bug.

This bug has been fixed by Commit 2b742094582d ("fs/kernfs: null-ptr deref in simple_xattrs_free()").
Commit 382b1e8f30f7 ("kernfs: fix memory leak of kernfs_iattrs in __kernfs_new_node")
was also caught from entering any stable releases, so the bug should be
fixed on all active branches.

Please correct me if this bug has not been fully addressed.

--
Will Rosenberg

